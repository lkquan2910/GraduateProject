class Admin::ProjectsController < GraduateProjectController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :destroy_attachment]
  before_action :get_icdo, except: [:index, :show, :destroy]

  # GET /admin/projects
  # GET /admin/projects.json
  def index
    authorize :project, :index?
    query = params[:query].presence || "*"
    @pagy, @projects = pagy(Project.search_result(query), items: Settings.admin.pagination.project.per_page)
  end

  def autocomplete
    render json: Project.autocomplete_result(params[:query])
  end


  # GET /admin/projects/1
  # GET /admin/projects/1.json
  def show
    authorize @project
  end

  # GET /admin/projects/new
  def new
    @district_children = []
    @ward_children = []
    @project = Project.new
    authorize @project
    @is_disabled = !policy(@project).create?
    @project.build_region
    @project.milestones.build(
      [
        { event_time: '', event: 'Khởi công', is_default: true },
        { event_time: '', event: 'Dự kiến bàn giao', is_default: true }
      ]
    )
    @project.legal_documents.build
    @cities = RegionData.cities.pluck(:name_with_type, :id)
  end

  # GET /admin/projects/1/edit
  def edit
    authorize @project
    @is_disabled = !policy(@project).update?
    @cities = RegionData.cities.pluck(:name_with_type, :id)
    customer_city_id = @project.region.present? && @project.region.city.present? ? @project.region.city.id : ''
    customer_district_id = @project.region.present? && @project.region.district.present? ? @project.region.district.id : ''
    @district_children = RegionData.where(parent_id: customer_city_id).order(:name).pluck(:name_with_type, :id)
    @ward_children = RegionData.where(parent_id: customer_district_id).order(:name).pluck(:name_with_type, :id)
  end

  # POST /admin/projects
  # POST /admin/projects.json
  def create
    @cities = RegionData.cities.pluck(:name_with_type, :id)
    @project = Project.new(project_params)
    authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to edit_admin_project_path(@project.id), notice: 'Dự án đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @project }
      else
        customer_city_id = @project.region.present? && @project.region.city.present? ? @project.region.city.id : ''
        customer_district_id = @project.region.present? && @project.region.district.present? ? @project.region.district.id : ''
        @district_children = RegionData.where(parent_id: customer_city_id).order(:name).pluck(:name_with_type, :id)
        @ward_children = RegionData.where(parent_id: customer_district_id).order(:name).pluck(:name_with_type, :id)
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/projects/1
  # PATCH/PUT /admin/projects/1.json
  def update
    authorize @project
    @cities = RegionData.cities.pluck(:name_with_type, :id)
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to edit_admin_project_path(@project.id), notice: 'Dự án đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @project }
      else
        customer_city_id = @project.region.present? && @project.region.city.present? ? @project.region.city.id : ''
        customer_district_id = @project.region.present? && @project.region.district.present? ? @project.region.district.id : ''
        @district_children = RegionData.where(parent_id: customer_city_id).order(:name).pluck(:name_with_type, :id)
        @ward_children = RegionData.where(parent_id: customer_district_id).order(:name).pluck(:name_with_type, :id)
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/projects/1
  # DELETE /admin/projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to admin_projects_url, notice: 'Xóa thành công.' }
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
    if @project.valid?
      @project.save
      @project.reload
      render json: {}
    else
      render json: { error: @project.errors[params[:type].to_sym]&.first }
    end
  end

  def import
    authorize :project, :import?
    ImportProjectJob.perform params[:file]&.path, current_user
  end

  private

  def delete_attachment type, name: nil
    @project.not_required_image = true
    if name.present?
      remain_attachments = @project.send(type)
      # if @project.send(type).size == 1
      #   @project.send("remove_#{type}!")
      # else
      index = nil
      remain_attachments.each_with_index { |a, idx| index = idx and break if a.identifier == name }
      deleted_image = remain_attachments.delete_at(index) if index
      deleted_image.try(:remove!)
      @project[type.to_sym] = remain_attachments
      # end
    else
      @project.send("remove_#{type}!")
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  def get_icdo
    @investors = Investor.pluck(:name, :id)
    @constructors = Constructor.pluck(:name, :id)
    @developments = Development.pluck(:name, :id)
    @operators = Operator.pluck(:name, :id)
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params[:project][:investors] = params[:project][:investors].nil? ? [] : params[:project][:investors].reject { |n| n.blank? }
    params[:project][:real_estate_type] = params[:project][:real_estate_type].nil? ? [] : params[:project][:real_estate_type].reject { |n| n.blank? }
    params[:project][:constructors] = params[:project][:constructors].nil? ? [] : params[:project][:constructors].reject { |n| n.blank? }
    params[:project][:developments] = params[:project][:developments].nil? ? [] : params[:project][:developments].reject { |n| n.blank? }
    params[:project][:operators] = params[:project][:operators].nil? ? [] : params[:project][:operators].reject { |n| n.blank? }
    params[:project][:features] = params[:project][:features].nil? ? [] : params[:project][:features].reject { |n| n.blank? }
    params.require(:project).permit(:name, :locking_time, :construction_density, :total_area, :high_level_number, :low_level_number,
                                    :price_from, :price_to, :area_from, :area_to, :custom_description, :custom_sale_policy, :custom_utilities,
                                    { :real_estate_type => [] }, { :features => [] }, :description, { images: [] }, { floorplan_images: [] }, :sale_policy, :sale_policy_cache,
                                    :images_cache, :floorplan_images_cache,
                                    { :internal_utilities => [] }, :external_utilities, :ownership_period, :foreigner, { banks: [] },
                                    :loan_percentage_support, :loan_support_period, :commission_type, :commission, :bonus, { :investors => [] },
                                    { :constructors => [] }, { :developments => [] }, { :operators => [] },
                                    milestones_attributes: [:id, :event, :event_time, :is_default, :_destroy],
                                    legal_documents_attributes: [:id, :doc_type, :doc, :doc_cache, :_destroy],
                                    payment_schedules_attributes: [:id, :name, :label_schedule, :pay, :_destroy],
                                    region_attributes: [:city_id, :district_id, :ward_id, :street, :objectable_id, :objectable_type])
  end
end
