class Admin::UsersController < GraduateProjectController
  before_action :find_user, except: [:index, :create, :new, :search, :autocomplete]

  def index
    authorize :user, :index?
    @users = User.includes(:role).where.not(id: current_user.id).order(id: :asc)
    query = params[:query].presence || "*"
    @users = @users.search_result(query)
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def update
    authorize @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user.id), notice: 'Tài khoản đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(user_params)
    authorize @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user.id), notice: 'Tài khoản đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @user }
      else
        format.html { render new_admin_user_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @user
    respond_to do |format|
      begin
        @user.destroy
        format.html { redirect_to admin_users_url, notice: 'Xóa thành công.' }
        format.json { head :no_content }
      rescue Exception => e
        if e.class.to_s == "Ancestry::AncestryException"
          flash[:error] = "Không thể xóa bản ghi này do có cấp dưới."
        else
          flash[:error] = e.message
        end
        format.html { redirect_to admin_users_url }
      end
    end
  end

  def search
    redirect_to admin_users_path(query: params[:query])
  end

  def autocomplete
    render json: User.autocomplete_result(params[:query])
  end

  private

  def find_user
    @user = User.includes(:role).find_by_id(params[:id])
    redirect_to admin_users_path unless @user.present?
  end

  def user_params
    if params[:user][:password].present?
      params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :account_type, :role_id, :deactivated, :is_superadmin)
    else
      params.require(:user).permit(:email, :full_name, :account_type, :role_id, :deactivated, :is_superadmin)
    end
  end
end
