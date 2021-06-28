class Admin::RolesController < GraduateProjectController
  before_action :check_permission
  before_action :find_role, only: [:edit, :update, :show, :destroy]

  def index
    @pagy, @roles = pagy(Role.all, items: Settings.admin.pagination.role.per_page)
  end

  def show
  end

  def new
    @role = Role.new
    @permissions = []
    Permission::LIST_MODEL_NAME.keys.each do |model_name|
      @permissions.push(@role.permissions.new(name: model_name))
    end
    @permissions = @permissions.sort_by { |hsh| hsh[:name] }

  end

  def edit
    @permissions = @role.permissions.order(:name)
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to edit_admin_role_path(@role.id), notice: 'Quyền đã được chỉnh sửa thành công.' }
        format.json { render :edit, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to edit_admin_role_path(@role.id), notice: 'Quyền đã được tạo thành công.' }
        format.json { render :edit, status: :created, location: @role }
      else
        format.html { render new_admin_role_path }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @role.users.blank?
      @role.destroy
      respond_to do |format|
        format.html { redirect_to admin_roles_url, notice: 'Xóa thành công.' }
        format.json { head :no_content }
      end
    else
      redirect_to admin_roles_path, alert: 'Quyền đã được gán cho tài khoản. Vui lòng gỡ khỏi tài khoản để xóa.'
    end
  end

  private

  def find_role
    @role = Role.find_by_id params[:id]
    redirect_to admin_roles_path unless @role.present?
  end

  def check_permission
    unless current_user.super_admin?
      respond_to do |format|
        flash[:error] = 'Bạn không có quyền thực hiện hành động này.'
        format.html { redirect_to root_path}
      end
    end
  end

  def role_params
    params.require(:role).permit(:name,
                                 permissions_attributes: [
                                   :id, :name, :can_edit, :can_create, :can_edit_other, :change_state,
                                   :can_view, :can_view_other, :can_delete, :can_delete_other, :can_import, :role_id
                                 ])
  end
end
