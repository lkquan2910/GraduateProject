class Admin::ConstructorsController < GraduateProjectController
  before_action :set_constructor, only: [:show, :edit, :update, :destroy_attachment, :destroy]

  # GET /constructors
  # GET /constructors.json
  def index
    authorize :constructor, :index?
    query = params[:query].presence || "*"
    @pagy, @constructors = pagy(Constructor.search_result(query), items: Settings.admin.pagination.icdo.per_page)
  end

  def autocomplete
    render json: Constructor.autocomplete_result(params[:query])
  end

  # GET /constructors/1
  # GET /constructors/1.json
  def show
    authorize @constructor
  end

  # GET /constructors/new
  def new
    @constructor = Constructor.new
    authorize @constructor
    @is_disabled = !policy(@constructor).create?
  end

  # GET /constructors/1/edit
  def edit
    authorize @constructor
    @is_disabled = !policy(@constructor).update?
  end

  # POST /constructors
  # POST /constructors.json
  def create
    @constructor = Constructor.new(constructor_params)
    authorize @constructor

    respond_to do |format|
      if @constructor.save
        format.html { redirect_to edit_admin_constructor_path(@constructor.id), notice: 'Chủ đầu tư đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @constructor }
      else
        format.html { render :edit }
        format.json { render json: @constructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /constructors/1
  # PATCH/PUT /constructors/1.json
  def update
    authorize @constructor
    respond_to do |format|
      if @constructor.update(constructor_params)
        format.html { redirect_to edit_admin_constructor_path(@constructor.id), notice: 'Chủ đầu tư đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @constructor }
      else
        format.html { render :edit }
        format.json { render json: @constructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /constructors/1
  # DELETE /constructors/1.json
  def destroy
    authorize @constructor
    @constructor.destroy
    respond_to do |format|
      format.html { redirect_to admin_constructors_url, notice: 'Xóa thành công.' }
      format.json { head :no_content }
    end
  end

  def destroy_attachment
    delete_attachment(params[:type])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_constructor
    @constructor = Constructor.find(params[:id])
  end

  def delete_attachment type
    @constructor.send("remove_#{type}!")
    if @constructor.valid?
      @constructor.save
      @constructor.reload
      render json: {}
    else
      render json: { error: @constructor.errors[params[:type].to_sym]&.first }
    end
  end

  # Only allow a list of trusted parameters through.
  def constructor_params
    params.require(:constructor).permit(:name, :description, :logo)
  end
end
