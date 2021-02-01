class Customer < ApplicationRecord
  include AASM
  # Associations
  belongs_to :city, class_name: 'RegionData', foreign_key: :city_id, optional: true
  has_many :notes, as: :objectable, dependent: :destroy
  accepts_nested_attributes_for :notes, allow_destroy: true

  # Validations
  validates :name, presence: true, format: { with: /\s/ }
  # validates :phone_number, presence: true, uniqueness: true, format: { with: /\A([+]\w|)+[0-9]*$\z/ }
  validates :phone_number, presence: true, format: { with: /\A([+]\w|)+[0-9]*$\z/ }
  #, unless: -> { User.current.marketing? || User.current.super_admin?
  validates :email, allow_blank: true, format: { with: /\A^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$\z/ }
  validates :identity_card, allow_blank: true, format: { with: /\A^(?=[A-Z0-9]*$)(?:.{9}|.{12})$\z/ }

  # AASM
  aasm column: :state, whiny_transitions: false do
    state :inauthentic, initial: true   # Chưa xác thực
    state :phone_authentic              # Xác thực số điện thoại
    state :authentic                    # Xác thực đầy đủ
  end

  scope :by_ids, -> (ids) { where id: ids }

  def get_gender
    Constant::CUSTOMER_GENDER.invert.key(gender)
  end

  def get_dob
    dob.present? ? dob.strftime('%d/%m/%Y') : ''
  end

  def name_and_phone
    "#{name} - #{phone_number}"
  end

  def get_state
    I18n.t("customer.states.#{self.aasm.current_state}")
  end
end
