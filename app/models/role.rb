class Role < ApplicationRecord

  # Associations
  has_many :users, dependent: :nullify #user.role_id = nil when role deleted
  has_many :permissions

  accepts_nested_attributes_for :permissions

  # Validations
  validates :name, presence: true, uniqueness: true

  ROLE_SHORT = {
    "Sale Member" => "NVKD",
    "Sale Leader" => "TNKD",
    "Sale Admin" => "TPKD",
    "Giám đốc kinh doanh" => "GDKD"
  }
end
