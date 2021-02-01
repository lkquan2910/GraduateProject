class Admin::CustomersController < GraduateProjectController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /admin/customers
  # GET /admin/customers.json
  def index
    @customers = Customer.all
  end

  # GET /admin/customers/1
  # GET /admin/customers/1.json
  def show
  end

  # GET /admin/customers/new
  def new
    @customer = Customer.new
    @cities = RegionData.cities.pluck(:name_with_type, :id)
  end

  # GET /admin/customers/1/edit
  def edit
    #@is_disabled = !policy(@customer).update?
    @cities = RegionData.cities.pluck(:name_with_type, :id)
    @customer_notes = @customer.notes
  end

  # POST /admin/customers
  # POST /admin/customers.json
  def create
    @customer = Customer.new(customer_params)
    @customer.created_by_id = current_user.id
    #if params[:form_id] == 'quick_create'
    #  authorize @customer
    #  respond_to do |format|
    #    @customer.save if @customer.valid?
    #    format.js { render :new }
    #  end
    #  return
    #end
    @cities = RegionData.cities.pluck(:name_with_type, :id)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to edit_admin_customer_path(@customer.id), notice: 'Khách hàng đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    @cities = RegionData.cities.pluck(:name_with_type, :id)
    #if params[:save_visit_journey] || params[:save_form_journey]
    #  respond_to do |format|
    #    @customer.assign_attributes(customer_params)
    #    @customer.save if @customer.valid?
    #    format.js { render :edit }
    #  end
    #elsif params[:cancel]
    #  respond_to do |format|
    #    format.js { render :edit }
    #  end
    #else
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to edit_admin_customer_path(@customer.id), notice: 'Khách hàng đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/customers/1
  # DELETE /admin/customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to admin_customers_url, notice: 'Xóa thành công.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
    @is_disabled = false
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:name, :phone_number, :second_phone_number, :gender, :email, :identity_card, :city_id, :address, :dob,
                                     :data_source, :country_code, { :customer_characteristic => [] }, :facebook_uid, :job, :property_ownership, :nationality, :financial_capability,
                                     :detail, :income, :position, :work_place, :marital_status, notes_attributes: [:id, :created_by_id, :content, :_destroy],
                                     visit_journeys_attributes: [:id, :title, :visited_link, :visited_date, :visit_id, :_destroy],
                                     form_journeys_attributes: [:id, :recent_conversion, :first_name, :last_name, :phone_number, :email, :recent_conversion_date, :_destroy])
  end
end
