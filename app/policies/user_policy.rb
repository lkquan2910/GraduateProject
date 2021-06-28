class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user
  def initialize current_user, user
    @current_user = current_user
    @user = user
  end

  def index?
    return false unless @current_user.internal?
    # @current_user.check_permission 'User', 'can_view'
    @current_user.check_permission_index 'User'
  end

  def update?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_edit'
  end

  def edit?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_edit'
  end

  def edit_other?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_edit_other'
  end

  def create?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_create'
  end

  def import?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_import'
  end

  def show?
    return false unless @current_user.internal?
    @current_user.check_permission(@user.class.to_s, 'can_view') ||
    create? || update? || change_state?
  end

  def show_other?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_view_other'
  end

  def destroy?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_delete'
  end

  def destroy_other?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'can_delete_other'
  end

  def change_state?
    return false unless @current_user.internal?
    @current_user.check_permission @user.class.to_s, 'change_state'
  end
end
