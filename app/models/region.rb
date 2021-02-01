class Region < ApplicationRecord

  # Associations
  belongs_to :city, :class_name => 'RegionData', optional: true
  belongs_to :district, :class_name => 'RegionData', optional: true
  belongs_to :ward, :class_name => 'RegionData', optional: true
  belongs_to :objectable, polymorphic: true

  # Validations
  validates :city_id, presence: true
  validates :district_id, presence: true
end
