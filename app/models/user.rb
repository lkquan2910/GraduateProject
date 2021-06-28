class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include UserSearch
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  enum account_type: [:internal, :investor, :agent]

  # Association
  belongs_to :role, optional: true
  belongs_to :group, optional: true

  # Validations
  validates :email, presence: true
  validates :password, presence: true,
            confirmation: true,
            length: {within: 6..40},
            on: :create
  validates :password, confirmation: true,
            length: {within: 6..40},
            allow_blank: true,
            on: :update
  validates :full_name, presence: true, format: { with: /\s/ }
  validates :account_type, presence: true
  validates :role_id, presence: true

  scope :by_ids, -> (ids){ where id: ids }

  def send_password_reset
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end

  def expired?
    expires_at < Time.current.to_i
  end

  def active_for_authentication?
    # TODO: solution Google Calendar
    # super && !deactivated
    !deactivated
  end

  def status
    deactivated? ? 'Vô hiệu hóa' : 'Hoạt động'
  end

  def send_password_reset
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end

  def super_admin?
    self.is_superadmin === true || false
  end

  def sale_leader?
    ['Sale Leader'].include? self.role.name.strip
  end

  def sale_manager?
    ['Giám đốc kinh doanh'].include? self.role.name.strip
  end

  def sale_member?
    ['Sale Member'].include? self.role.name.strip
  end

  def sale_admin?
    ['Sale Admin'].include? self.role.name.strip
  end

  def accounting?
    ['Kế toán'].include? self.role.name.strip
  end

  def leader_accounting?
    ['Leader Kế toán'].include? self.role.name.strip
  end

  def marketing?
    ['Marketing'].include? self.role.name.strip
  end

  def self.current
    Thread.current[:user]
  end

  def leader
    self.ancestors.joins(:role).where(roles: { name: ['Sale Leader'] })&.first
  end

  def leader_recall
    self.parent if self.parent&.role&.name == 'Sale Leader'
  end

  def manager
    self.ancestors.joins(:role).where(roles: { name: ['Giám đốc kinh doanh'] })&.first
  end

  def leaders
    self.ancestors.joins(:role).where(roles: { name: ['Sale Leader'] })
  end

  def managers
    self.ancestors.joins(:role).where(roles: { name: ['Giám đốc kinh doanh'] })
  end

  def accountant
    self.root.descendants.joins(:role).where(roles: {name: ['Kế toán']})&.first
  end

  def leader_accountant
    self.root.descendants.joins(:role).where(roles: {name: ['Leader Kế toán']})&.first
  end

  def sale_admin
    self.root.descendants.joins(:role).where(roles: {name: ['Sale Admin']})&.first
  end

  def self.managers
    joins(:role).where(roles: { name: ['Giám đốc kinh doanh'] })
  end

  def self.sale_admins
    joins(:role).where(roles: { name: ['Sale Admin'] })
  end

  def self.leaders
    joins(:role).where(roles: { name: ['Sale Leader'] })
  end

  def members
    self.descendants
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def check_permission(model_name, permission_type)
    role = self.role
    permission_name = Permission::LIST_MODEL_NAME.key(model_name)
    return false unless role.present? && permission_name.present?
    permission = role.permissions.find_by_name(permission_name)
    return false unless permission.present? && permission.respond_to?(permission_type)
    permission.send(permission_type)
  end

  def check_permission_index(model_name)
    role = self.role
    permission_name = Permission::LIST_MODEL_NAME.key(model_name)
    return false if role.blank? || permission_name.blank?
    permission = role.permissions.find_by_name(permission_name)
    return false if permission.blank?
    permission.can_create ||
    permission.can_edit ||
    permission.can_edit_other ||
    permission.can_view ||
    permission.can_view_other ||
    permission.can_delete ||
    permission.can_delete_other ||
    permission.can_import ||
    permission.change_state
  end
end
