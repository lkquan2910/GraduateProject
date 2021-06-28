class Admin::ProductsController < GraduateProjectController
  before_action :load_product, only: [:new, :edit, :update, :create, :destroy, :destroy_attachment]

  def index
    authorize :product, :index?
    @project = Project.find_by(id: params[:project_id])
    params[:level] ||= 0
    @high_pagy, @high_products = load_products 0
    @low_pagy, @low_products = load_products 1
  end

  def search
    redirect_to admin_project_products_path(project_id: params[:project_id], level: params[:level]&.to_i,
                                            high_query: params[:high_query], low_query: params[:low_query])
  end

  def autocomplete
    @project = Project.find_by(id: params[:project_id])
    render json: @project.products.autocomplete_result(params[:query], level: params[:level]&.to_i)
  end

  def get_divisions
    @divisions = if params[:is_project].present?
                   Division.where(project_id: params[:parent_id])
                 else
                   Division.where(parent_id: params[:parent_id])
                 end

    respond_to do |format|
      format.json { render json: @divisions }
    end
  end

  def import
    authorize :product, :import?
    ImportProductJob.perform params[:file]&.path, params[:project_id], current_user
  end

  def export_template
    file_name = "Bang_hang_#{Time.now.strftime(Settings.date.formats.time_export_xlsx)}.xlsx"
    export_to_xlsx ProductService.new.export_template, file_name
  end

  def new
    @product = @project.products.build level: (params[:level] || 0)
    authorize @product
    @is_disabled = !policy(@product).create?
  end

  def edit
    if policy(@product).change_state? || policy(@product).update? || policy(@product).show?
      @is_disabled = !policy(@product).update?
      @state_is_disable = !policy(@product).change_state?
    else
      respond_to do |format|
        flash[:error] = 'Bạn không có quyền thực hiện hành động này.'
        format.html { redirect_to admin_project_products_path }
      end
    end
  end

  def create
    return render json: {status: :ok} if params[:type].present?
    @product = @project.products.build product_params
    authorize @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_admin_project_product_path(@project, @product), notice: 'Thêm mới sản phẩm thành công!' }
        format.json { render :edit }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if policy(@product).change_state?
        @product.execute_state_change product_params[:state]
      end
      if policy(@product).change_state? || policy(@product).update?
        @product.assign_attributes product_params
        # logic deal product
        @deals = @product.deals.where.not(state: 'canceled')
        if params[:confirm].blank? && @product.state_changed? && ['recall', 'third_holding', 'third_sold'].include?(@product.state) && @deals.present?
          @show_confirm = true
          return render :edit
        end
        return redirect_to edit_admin_project_product_path(@project, @product) if params[:confirm].to_s == 'false'

        if @product.valid?
          @product.save
          format.html { redirect_to edit_admin_project_product_path(@project, @product), notice: 'Thay đổi thông tin sản phẩm thành công.' }
          format.json { render :edit, status: :ok, location: @product }
        else
          # format.html { redirect_to edit_admin_project_product_path(@project, @product) }
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      else
        flash[:error] = 'Bạn không có quyền thực hiện hành động này.'
        format.html { redirect_to edit_admin_project_product_path(@project, @product) }
      end
    end
  end

  def destroy
    authorize @product
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_project_products_path(@product.project), notice: 'Xoá thành công.' }
      format.json { head :no_content }
    end
  end

  def destroy_attachment
    case params[:type]
    when 'sale_policy'
      delete_attachment(params[:type])
    else
      delete_attachment(params[:type], name: params[:filename])
    end
    if @product.valid?
      @product.save
      @product.reload
      render json: {}
    else
      render json: { error: @product.errors[params[:type].to_sym]&.first }
    end

  end

  private

  def delete_attachment type, name: nil
    if name.present?
      remain_attachments = @product.send(type)
      # if @product.send(type).size == 1
      #   @product.send("remove_#{type}!")
      # else
      index = nil
      remain_attachments.each_with_index { |a, idx| index = idx and break if a.identifier == name }
      deleted_image = remain_attachments.delete_at(index) if index
      deleted_image.try(:remove!)
      @product[type.to_sym] = remain_attachments
      # end
    else
      @product.send("remove_#{type}!")
    end
  end

  def load_product
    @projects = Project.where(id: params[:project_id]).pluck(:name, :id)
    @project = Project.find_by(id: params[:project_id])
    @product = @project.products.find_by(id: params[:id])
    if @product
      @stored_state = @product.state
      @deposits = @product.deposits.where.not(state: :canceled).map { |d| [d.name, edit_admin_deposit_path(d)] }
    else
      @stored_state = nil
      @deposits = nil
    end
    @subdivisions = Division.where(project_id: params[:project_id]).pluck(:name, :id)
    @blocks = Division.where(parent_id: @product&.subdivision_id).pluck(:name, :id)
    @floors = Division.where(parent_id: @product&.block_id).pluck(:name, :id)
  end

  def load_products level
    page = level == params[:level]&.to_i ? params[:page]&.to_i : Settings.admin.pagination.product.page
    query = level == 0 ? params[:high_query] : params[:low_query]
    pagy((query.present? ? @project.products.search_result(query, level: level) : @project.products.where(level: level)),
         items: Settings.admin.pagination.product.per_page, page: page)
  end

  def product_params
    level = (params.require(:product)[:level] || @product&.level)&.to_i
    if policy(@product).update? && policy(@product).change_state?
      params.require(:product).permit(level == 0 ? Product::HIGH_ATTRS : Product::LOW_ATTRS)
    elsif !policy(@product).update? && policy(@product).change_state?
      params.require(:product).permit(:state)
    elsif policy(@product).update? && !policy(@product).change_state?
      params.require(:product).permit(level == 0 ? Product::HIGH_ATTRS_NOT_STATE : Product::LOW_ATTRS_NOT_STATE)
    end
  end

  def export_to_xlsx file, file_name
    tempfile = "#{Rails.root}/tmp/tempfile.xlsx"

    file.serialize tempfile
    ::File.open tempfile, "r" do |f|
      send_data f.read, filename: file_name, type: "application/xlsx"
    end
    ::File.delete tempfile
  end
end
