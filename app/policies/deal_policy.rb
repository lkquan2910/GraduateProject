class DealPolicy < ApplicationPolicy
  attr_reader :user, :deal
  def initialize user, deal
    @user = user
    @deal = deal
  end

  def index?
    return false unless @user.internal?
    @user.check_permission_index 'Deal'
  end

  def update?
    scope = Deal.where(id: deal.id)
    scope = scope.where(assignee_id: user.id) unless @user.check_permission @deal.class.to_s, 'can_edit_other'
    return false if !@user.internal? || Scope.new(user, scope).resolve.blank?
    @user.check_permission(@deal.class.to_s, 'can_edit') ||
    @user.check_permission(@deal.class.to_s, 'can_edit_other')
  end

  # def edit?
  #   return false unless @user.internal?
  #   @user.check_permission @deal.class.to_s, 'can_edit'
  # end

  def edit_other?
    return false unless @user.internal?
    @user.check_permission @deal.class.to_s, 'can_edit_other'
  end

  def create?
    return false unless @user.internal?
    @user.check_permission @deal.class.to_s, 'can_create'
  end

  def import?
    return false unless @user.internal?
    @user.check_permission @deal.class.to_s, 'can_import'
  end

  def show?
    return false if !@user.internal? || Scope.new(user, Deal.where(id: deal.id)).resolve.blank?
    @user.check_permission(@deal.class.to_s, 'can_view') ||
    @user.check_permission(@deal.class.to_s, 'can_view_other') ||
    create? || update? || change_state?
  end

  def show_other?
    return false unless @user.internal?
    @user.check_permission @deal.class.to_s, 'can_view_other'
  end

  def destroy?
    return false if !@user.internal? || Scope.new(user, Deal.where(id: deal.id)).resolve.blank?
    @user.check_permission @deal.class.to_s, 'can_delete'
  end

  def destroy_other?
    return false unless @user.internal?
    @user.check_permission @deal.class.to_s, 'can_delete_other'
  end

  def change_state?
    return false unless @user.internal?
    @user.check_permission @deal.class.to_s, 'change_state'
  end

  class Scope < Scope
    def resolve
      return raise Pundit::NotAuthorizedError, 'not allowed to view this action' unless user.internal?
      user_ids = []
      if user.super_admin? || user.sale_manager? || user.accounting? || user.leader_accounting? || user.sale_admin? || user.marketing?
        # user_ids = user.group.user_ids if user.group
        user_ids = User.ids.push(nil)
      elsif user.check_permission "Deal", 'can_view_other'
        user_ids = user.subtree_ids
      else
        user_ids = [user.id]
      end
      records = scope.where(assignee_id: user_ids)
      records.where(state: ['lock', 'confirm', 'book', 'deposit', 'contract_signed', 'completed', 'canceled', 'recall', 'request_recall']) if user.sale_admin?
      return records
    end
  end
end
