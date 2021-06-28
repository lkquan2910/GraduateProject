class ConstructorPolicy < ApplicationPolicy
  attr_reader :user, :constructor
  def initialize user, constructor
    @user = user
    @constructor = constructor
  end

  def index?
    return false unless @user.internal?
    @user.check_permission_index 'Constructor'
  end

  def update?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'can_edit'
  end

  # def edit?
  #   return false unless @user.internal?
  #   @user.check_permission @constructor.class.to_s, 'can_edit'
  # end

  def edit_other?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'can_edit_other'
  end

  def create?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'can_create'
  end

  def import?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'can_import'
  end

  def show?
    return false unless @user.internal?
    @user.check_permission(@constructor.class.to_s, 'can_view') ||
    create? || update? || change_state?
  end

  def show_other?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'can_view_other'
  end

  def destroy?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'can_delete'
  end

  def destroy_other?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'can_delete_other'
  end

  def change_state?
    return false unless @user.internal?
    @user.check_permission @constructor.class.to_s, 'change_state'
  end
end
