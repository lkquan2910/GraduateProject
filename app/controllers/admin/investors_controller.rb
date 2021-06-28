class Admin::InvestorsController < GraduateProjectController
  before_action :set_investor, only: [:show, :edit, :update, :destroy_attachment, :destroy]

  # GET /investors
  # GET /investors.json
  def index
    authorize :investor, :index?
    query = params[:query].presence || "*"
    @pagy, @investors = pagy(Investor.search_result(query), items: Settings.admin.pagination.icdo.per_page)
  end

  def autocomplete
    render json: Investor.autocomplete_result(params[:query])
  end

  # GET /investors/1
  # GET /investors/1.json
  def show
    authorize @investor
  end

  # GET /investors/new
  def new
    @investor = Investor.new
    authorize @investor
    @is_disabled = !policy(@investor).create?
  end

  # GET /investors/1/edit
  def edit
    authorize @investor
    @is_disabled = !policy(@investor).update?
  end

  # POST /investors
  # POST /investors.json
  def create
    @investor = Investor.new(investor_params)
    authorize @investor

    respond_to do |format|
      if @investor.save
        format.html { redirect_to edit_admin_investor_path(@investor.id), notice: 'Chủ đầu tư đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @investor }
      else
        format.html { render :edit }
        format.json { render json: @investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investors/1
  # PATCH/PUT /investors/1.json
  def update
    authorize @investor
    respond_to do |format|
      if @investor.update(investor_params)
        format.html { redirect_to edit_admin_investor_path(@investor.id), notice: 'Chủ đầu tư đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @investor }
      else
        format.html { render :edit }
        format.json { render json: @investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investors/1
  # DELETE /investors/1.json
  def destroy
    authorize @investor
    @investor.destroy
    respond_to do |format|
      format.html { redirect_to admin_investors_url, notice: 'Xóa thành công.' }
      format.json { head :no_content }
    end
  end

  def destroy_attachment
    delete_attachment(params[:type])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_investor
    @investor = Investor.find(params[:id])
  end

  def delete_attachment type
    @investor.send("remove_#{type}!")
    if @investor.valid?
      @investor.save
      @investor.reload
      render json: {}
    else
      render json: { error: @investor.errors[params[:type].to_sym]&.first }
    end
  end

  # Only allow a list of trusted parameters through.
  def investor_params
    params.require(:investor).permit(:name, :description, :logo)
  end
end
