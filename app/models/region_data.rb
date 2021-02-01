class RegionData < ApplicationRecord

  self.table_name = 'region_datas'

  has_many :region_cities, class_name: "Region", foreign_key: "city_id"
  has_many :region_districts, class_name: "Region", foreign_key: "district_id"
  has_many :region_wards, class_name: "Region", foreign_key: "ward_id"

  belongs_to :parent, class_name: "RegionData", foreign_key: "parent_id", optional: true

  scope :cities, -> { where(region_type: "Region::City").order(:name) }
  scope :districts, -> { where(region_type: "Region::District").order(:name) }
  scope :wards, -> { where(region_type: "Region::Ward").order(:name) }

  def self.check_and_insert_from_json(data, type, parent_id = 0)
    unless RegionData.where(:code => data[0]).exists?
      RegionData.create!(
        name: data[1]["name"],
        name_with_type: data[1]["name_with_type"],
        path: data[1]["path"],
        path_with_type: data[1]["path_with_type"],
        code: data[1]["code"],
        slug: data[1]["slug"],
        region_type: type,
        parent_id: parent_id,
        created_at: Time.now,
        updated_at: Time.now
      )
    end
    return RegionData.where(code: data[0]).first
  end
end