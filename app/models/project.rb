class Project < ApplicationRecord
  include ProjectSearch
  #include ConvertSlug

  attr_accessor :not_required_image

  mount_uploaders :images, ProjectImageUploader
  mount_uploaders :floorplan_images, ProjectFloorplanImageUploader
  mount_uploader :sale_policy, ProjectUploader

  # Callbacks
  after_commit :remove_previously_stored_sale_policy, on: :update
  after_update :update_deal_cached_at

  # Associations
  has_many :milestones, inverse_of: :project, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :layouts, dependent: :destroy
  has_many :divisions, dependent: :destroy
  accepts_nested_attributes_for :milestones, allow_destroy: true
  has_many :legal_documents, inverse_of: :project, dependent: :destroy
  accepts_nested_attributes_for :legal_documents, allow_destroy: true
  has_one :region, as: :objectable, dependent: :destroy
  accepts_nested_attributes_for :region, allow_destroy: true
  has_many :payment_schedules, inverse_of: :project, dependent: :destroy
  accepts_nested_attributes_for :payment_schedules, allow_destroy: true
  #has_many :customer_tickets, as: :objectable, dependent: :destroy
  #has_many :interactive_layouts, inverse_of: :project, dependent: :destroy
  #accepts_nested_attributes_for :interactive_layouts, allow_destroy: true
  #has_many :key_values, inverse_of: :project, dependent: :destroy
  #accepts_nested_attributes_for :key_values, allow_destroy: true
  #has_many :floorplan_images, inverse_of: :project, dependent: :destroy
  #accepts_nested_attributes_for :floorplan_images, allow_destroy: true
  #has_many :documents, inverse_of: :project, dependent: :destroy
  #accepts_nested_attributes_for :documents, allow_destroy: true
  has_many :regulations
  has_many :deals


  # Validations
  validates :name, presence: true
  validates :real_estate_type, presence: true
  validates :locking_time, numericality: { allow_blank: true, only_integer: true, greater_than_or_equal_to: 0 }
  validates :construction_density, numericality: { greater_than: 0, less_than_or_equal_to: 100 }, allow_blank: true
  validates :total_area, numericality: { greater_than: 0 }, allow_blank: true
  validates :investors, presence: true
  validates :internal_utilities, presence: true
  validates :ownership_period, presence: true
  validates :loan_percentage_support, numericality: { greater_than: 0, less_than_or_equal_to: 100 }, allow_blank: true
  validates :loan_support_period, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  #validates :discount_support, numericality: { greater_than: 0, less_than_or_equal_to: 100 }, allow_blank: true
  # validates :bonus, numericality: { greater_than: 0 }, allow_blank: true
  # validate :commission_validate_by_commission_type
  validates :images, presence: true, unless: -> { not_required_image.present? }
  validates :high_level_number, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :low_level_number, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validate :payment_schedule_validate
  validates :price_from, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }, allow_blank: true
  validates :price_to, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }, allow_blank: true
  validates :area_from, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :area_to, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  #validate :interactive_layout_validate
  #validates :link_video, :position_link_embed, valid_url: true


  scope :by_ids, -> (ids) { where id: ids }

  def update_deal_cached_at
    self.deals.update_all(cached_at: Time.now)
  end

  def commission_validate_by_commission_type
    if commission_type.to_i == 1 && commission.present?
      if commission.to_i == 0
        errors.add(:commission, 'Hoa h???ng (VN??) ph???i l?? s???.')
      elsif commission >= 100
        errors.add(:commission, 'Hoa h???ng (VN??) kh??ng ???????c qu?? 100%.')
      elsif commission < 0
        errors.add(:commission, 'Hoa h???ng (VN??) kh??ng ???????c nh???p nh??? h??n 0.')
      end
    end
    if commission_type.to_i == 0 && commission.present?
      if commission.to_i == 0
        errors.add(:commission, 'Hoa h???ng (VN??) ph???i l?? s???.')
      elsif commission < 0
        errors.add(:commission, 'Hoa h???ng (VN??) kh??ng ???????c nh???p nh??? h??n 0.')
      end
    end
    if commission_type.blank? && commission.present?
      errors.add(:commission_type, 'Vui l??ng ch???n h??nh th???c t??nh ph?? c???a d??? ??n.')
    end
  end

  def min_price
    products.minimum(:sum_price) || price_from ? price_from.to_f * 1000000000 : nil
  end

  def max_price
    products.maximum(:sum_price) || price_to ? price_to.to_f * 1000000000 : nil
  end

  def min_price_filter
    products.present? ? products.minimum(:sum_price) : price_from.to_f * 1000000000
  end

  def max_price_filter
    products.present? ? products.maximum(:sum_price) : price_to.to_f * 1000000000
  end

  def min_acreage
    [products.minimum(:carpet_area), products.minimum(:plot_area)].compact.min || area_from
  end

  def max_acreage
    [products.maximum(:carpet_area), products.maximum(:plot_area)].compact.max || area_to
  end

  def min_acreage_filter
    [products.minimum(:carpet_area), products.minimum(:plot_area)].compact.min || area_from.to_f
  end

  def max_acreage_filter
    [products.maximum(:carpet_area), products.maximum(:plot_area)].compact.max || area_to.to_f
  end

  def furnitures
    products&.map(&:furniture).compact.uniq
  end

  def online_transaction
    products.present?
  end

  def investors_name
    Investor.where(id: investors).map(&:name)
  end

  def real_estate_type_name
    real_estate_type&.map { |t| Constant::PROJECT_REAL_ESTATE_TYPE[t] }
  end

  def full_address
    "#{region.city&.name} #{region.district&.name} #{region.ward&.name}"
  end

  def currencies
    products&.map(&:currency).compact.uniq.map { |c| Constant::PRODUCT_CURRENCIES[c] }
  end

  def payment_schedule_validate
    high_payment_schedules = payment_schedules.reject { |p| p._destroy || p.label_schedule != 0 }
    low_payment_schedules = payment_schedules.reject { |p| p._destroy || p.label_schedule != 1 }
    high = high_payment_schedules.size
    low = low_payment_schedules.size
    value_high = high_payment_schedules.map(&:pay).sum()
    value_low = low_payment_schedules.map(&:pay).sum()
    # check khoi cao tang
    errors.add(:high_level_number, :equal_to_payment_schedule) unless high == high_level_number.to_i
    errors.add(:high_level_number, :equal_to_value_payment_schedule) if high_level_number.to_i > 0 && high > 0 && value_high != 100
    # check khoi thap tang
    errors.add(:low_level_number, :equal_to_payment_schedule) unless low == low_level_number.to_i
    errors.add(:low_level_number, :equal_to_value_payment_schedule) if low_level_number.to_i > 0 && low > 0 && value_low != 100
  end

  #def interactive_layout_validate
  #  errors.add(:divis, "B???n ??ang nh???p 1 m???t b???ng 2 l???n") if interactive_layouts.map(&:division_id).uniq.size != interactive_layouts.map(&:division_id).size
  #end
end
