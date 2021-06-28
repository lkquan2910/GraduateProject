class Admin::DevelopmentsController < GraduateProjectController
  before_action :set_development, only: [:show, :edit, :update, :destroy_attachment, :destroy]

  # GET /developments
  # GET /developments.json
  def index
    authorize :development, :index?
    query = params[:query].presence || "*"
    @pagy, @developments = pagy(Development.search_result(query), items: Settings.admin.pagination.icdo.per_page)
  end

  def autocomplete
    render json: Development.autocomplete_result(params[:query])
  end

  # GET /developments/1
  # GET /developments/1.json
  def show
    authorize @development
  end

  # GET /developments/new
  def new
    @development = Development.new
    authorize @development
    @is_disabled = !policy(@development).create?
  end

  # GET /developments/1/edit
  def edit
    authorize @development
    @is_disabled = !policy(@development).update?
  end

  # POST /developments
  # POST /developments.json
  def create
    @development = Development.new(development_params)
    authorize @development

    respond_to do |format|
      if @development.save
        format.html { redirect_to edit_admin_development_path(@development.id), notice: 'Chủ đầu tư đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @development }
      else
        format.html { render :edit }
        format.json { render json: @development.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /developments/1
  # PATCH/PUT /developments/1.json
  def update
    #authorize @development
    respond_to do |format|
      if @development.update(development_params)
        format.html { redirect_to edit_admin_development_path(@development.id), notice: 'Chủ đầu tư đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @development }
      else
        format.html { render :edit }
        format.json { render json: @development.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developments/1
  # DELETE /developments/1.json
  def destroy
    authorize @development
    @development.destroy
    respond_to do |format|
      format.html { redirect_to admin_developments_url, notice: 'Xóa thành công.' }
      format.json { head :no_content }
    end
  end

  def destroy_attachment
    delete_attachment(params[:type])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_development
    @development = Development.find(params[:id])
  end

  def delete_attachment type
    @development.send("remove_#{type}!")
    if @development.valid?
      @development.save
      @development.reload
      render json: {}
    else
      render json: { error: @development.errors[params[:type].to_sym]&.first }
    end
  end

  # Only allow a list of trusted parameters through.
  def development_params
    params.require(:development).permit(:name, :description, :logo)
  end
end
