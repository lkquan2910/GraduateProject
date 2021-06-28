class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project
  def initialize user, project
    @user = user
    @project = project
  end

  def index?
    return false unless @user.internal?
    # @user.check_permission 'Project', 'can_view'
    @user.check_permission_index('Project') ||
    @user.check_permission_index('Product') ||
    @user.check_permission_index('Layout')
  end

  def update?
    return false unless @user.internal?
    @user.check_permission @project.class.to_s, 'can_edit'
  end

  def edit_other?
    return false unless @user.internal?
    @user.check_permission @project.class.to_s, 'can_edit_other'
  end

  def create?
    return false unless @user.internal?
    @user.check_permission @project.class.to_s, 'can_create'
  end

  def import?
    return false unless @user.internal?
    @user.check_permission 'Project', 'can_import'
  end

  def show?
    return false unless @user.internal?
    @user.check_permission(@product.class.to_s, 'can_view') ||
    create? || update? || change_state? ||
    @user.check_permission_index('Product') ||
    @user.check_permission_index('Layout')
    #@user.check_permission_index('CustomDetail')
  end

  def show_other?
    return false unless @user.internal?
    @user.check_permission @project.class.to_s, 'can_view_other'
  end

  def destroy?
    return false unless @user.internal?
    @user.check_permission @project.class.to_s, 'can_delete'
  end

  def destroy_other?
    return false unless @user.internal?
    @user.check_permission @project.class.to_s, 'can_delete_other'
  end

  def change_state?
    return false unless @user.internal?
    @user.check_permission @project.class.to_s, 'change_state'
  end
end
