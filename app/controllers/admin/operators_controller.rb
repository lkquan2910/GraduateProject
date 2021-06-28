class Admin::OperatorsController < GraduateProjectController
  before_action :set_operator, only: [:show, :edit, :update, :destroy_attachment, :destroy]

  # GET /operators
  # GET /operators.json
  def index
    authorize :operator, :index?
    query = params[:query].presence || "*"
    @pagy, @operators = pagy(Operator.search_result(query), items: Settings.admin.pagination.icdo.per_page)
  end

  def autocomplete
    render json: Operator.autocomplete_result(params[:query])
  end

  # GET /operators/1
  # GET /operators/1.json
  def show
    authorize @operator
  end

  # GET /operators/new
  def new
    @operator = Operator.new
    authorize @operator
    @is_disabled = !policy(@operator).create?
  end

  # GET /operators/1/edit
  def edit
    authorize @operator
    @is_disabled = !policy(@operator).update?
  end

  # POST /operators
  # POST /operators.json
  def create
    @operator = Operator.new(operator_params)
    authorize @operator

    respond_to do |format|
      if @operator.save
        format.html { redirect_to edit_admin_operator_path(@operator.id), notice: 'Chủ đầu tư đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @operator }
      else
        format.html { render :edit }
        format.json { render json: @operator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operators/1
  # PATCH/PUT /operators/1.json
  def update
    authorize @operator
    respond_to do |format|
      if @operator.update(operator_params)
        format.html { redirect_to edit_admin_operator_path(@operator.id), notice: 'Chủ đầu tư đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @operator }
      else
        format.html { render :edit }
        format.json { render json: @operator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operators/1
  # DELETE /operators/1.json
  def destroy
    authorize @operator
    @operator.destroy
    respond_to do |format|
      format.html { redirect_to admin_operators_url, notice: 'Xóa thành công.' }
      format.json { head :no_content }
    end
  end

  def destroy_attachment
    delete_attachment(params[:type])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operator
    @operator = Operator.find(params[:id])
  end

  def delete_attachment type
    @operator.send("remove_#{type}!")
    if @operator.valid?
      @operator.save
      @operator.reload
      render json: {}
    else
      render json: { error: @operator.errors[params[:type].to_sym]&.first }
    end
  end

  # Only allow a list of trusted parameters through.
  def operator_params
    params.require(:operator).permit(:name, :description, :logo)
  end
end
