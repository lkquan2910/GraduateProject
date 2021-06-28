class CustomerPolicy < ApplicationPolicy
  attr_reader :user, :customer
  def initialize user, customer
    @user = user
    @customer = customer
  end

  def index?
    return false unless @user.internal?
    @user.check_permission_index 'Customer'
  end

  def update?
    return false if !@user.internal? || Scope.new(user, Customer.where(id: customer.id)).resolve.blank?
    @user.check_permission @customer.class.to_s, 'can_edit'
  end

  def edit_other?
    return false unless @user.internal?
    @user.check_permission @customer.class.to_s, 'can_edit_other'
  end

  def create?
    return false unless @user.internal?
    @user.check_permission @customer.class.to_s, 'can_create'
  end

  def import?
    return false unless @user.internal?
    @user.check_permission 'Customer', 'can_import'
  end

  def show?
    return false if !@user.internal? || Scope.new(user, Customer.where(id: customer.id)).resolve.blank?
    @user.check_permission(@customer.class.to_s, 'can_view') ||
      create? || update? || change_state?
  end
  
  def show_other?
    return false unless @user.internal?
    @user.check_permission @customer.class.to_s, 'can_view_other'
  end

  def destroy?
    return false if !@user.internal? || Scope.new(user, Customer.where(id: customer.id)).resolve.blank?
    @user.check_permission @customer.class.to_s, 'can_delete'
  end

  def destroy_other?
    return false unless @user.internal?
    @user.check_permission @customer.class.to_s, 'can_delete_other'
  end

  def change_state?
    return false unless @user.internal?
    @user.check_permission @customer.class.to_s, 'change_state'
  end

  class Scope < Scope
    def resolve
      return raise Pundit::NotAuthorizedError, 'not allowed to view this action' unless user.internal?
      return scope.all if user.super_admin? || user.sale_manager?
      scope.where(created_by_id: user.id)
      #scope.where(id: Deal.where(assignee_id: user.subtree_ids).pluck('customer_id')).or(scope.where(created_by_id: user.subtree_ids))
    end
  end
end
