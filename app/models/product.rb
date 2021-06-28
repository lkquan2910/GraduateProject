class Product < ApplicationRecord

  # Include
  #include Rails.application.routes.url_helpers
  include ProductSearch
  include AASM
  #include ConvertSlug

  # Attributes Accessor

  # Uploader
  #mount_uploaders :images, ProductImageUploader

  # Constants
  HIGH_ATTRS = [:state, :project_id, :code, :subdivision_id, :block_id, :floor_id, :name,
                :level, :real_estate_type, :product_type, :direction, :built_up_area, :carpet_area,
                :currency, :price, :sum_price, :certificate, :use_term, :bedroom, :furniture, :furniture_quality, { images: [] }, { layout_image_names: [] }]
  LOW_ATTRS = [:state, :project_id, :code, :subdivision_id, :block_id, :name, :level,
               :real_estate_type, :product_type, :direction, :plot_area, :density, :floor_area, :setback_front,
               :setback_behind, :statics, :living_room, :bedroom, :bath_room, :dining_room, :multipurpose_room,
               :mini_bar, :drying_yard, :kitchen, :balcony, :business_space, :currency, :price, :sum_price,
               :certificate, :use_term, :handover_standards, { images: [] }, :images_cache, { layout_image_names: [] }]
  HIGH_ATTRS_NOT_STATE = [:project_id, :code, :subdivision_id, :block_id, :floor_id, :name,
                          :level, :real_estate_type, :product_type, :direction, :built_up_area, :carpet_area,
                          :currency, :price, :sum_price, :certificate, :use_term, :bedroom, :furniture, :furniture_quality, { images: [] }, :images_cache, { layout_image_names: [] }]
  LOW_ATTRS_NOT_STATE = [:project_id, :code, :subdivision_id, :block_id, :name, :level,
                         :real_estate_type, :product_type, :direction, :plot_area, :density, :floor_area, :setback_front,
                         :setback_behind, :statics, :living_room, :bedroom, :bath_room, :dining_room, :multipurpose_room,
                         :mini_bar, :drying_yard, :kitchen, :balcony, :business_space, :currency, :price, :sum_price,
                         :certificate, :use_term, :handover_standards, { images: [] }, { layout_image_names: [] }]

  # Delegates
  delegate :name, to: :project, prefix: :project, allow_nil: true
  delegate :locking_time, to: :project, allow_nil: true

  # Scopes
  scope :by_ids, -> (ids) { where id: ids }

  # Callbacks
  after_commit :stream_product
  after_destroy :delete_division_nil
  after_save :after_save_action

  # Associations
  belongs_to :project
  belongs_to :subdivision, class_name: 'Division', foreign_key: :subdivision_id
  belongs_to :block, class_name: 'Division', foreign_key: :block_id
  belongs_to :floor, class_name: 'Division', foreign_key: :floor_id, optional: true
  has_many :deposits, inverse_of: :product
  has_many :customer_tickets, as: :objectable, dependent: :destroy
  has_many :deals

  # Validations
  # validates :code, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: { scope: :project_id }
  validates :name, presence: true
  validates :state, presence: true
  validates :project_id, presence: true
  validates :subdivision_id, presence: true
  validates :block_id, presence: true
  validates :level, presence: true
  validates :real_estate_type, presence: true
  # validates :product_type, presence: true
  validates :direction, presence: true
  validates :currency, presence: true
  validates :price, presence: true, numericality: true
  validates :sum_price, presence: true, numericality: true
  validates :certificate, presence: true
  validates :use_term, presence: true
  validates :floor_id, presence: true, if: -> { level == 0 }
  validates :carpet_area, presence: true, if: -> { level == 0 }
  # validates :furniture, presence: true, if: -> { level == 0 }
  validates :plot_area, presence: true, if: -> { level == 1 }
  # validates :density, presence: true, if: -> { level == 1 }
  # validates :handover_standards, presence: true, if: -> { level == 1 }
  validate :validation_action

  # AASM
  aasm column: :state, whiny_transitions: false do
    after_all_transitions :action_after_transition

    state :for_sale, initial: true # Còn hàng
    state :locking # Đang lock
    state :book # Chờ book
    state :deposited # Đã đặt cọc
    state :contract_signed # Ký hợp đồng GD
    state :sold # Đã bán
    state :recall # Thu hồi
    state :third_holding # Sàn khác giữ
    state :third_sold # Sàn khác bán

    event :to_for_sale do
      transitions from: [:recall, :third_holding], to: :for_sale
    end
    event :to_recall do
      transitions from: [:for_sale, :locking, :book, :deposited, :contract_signed, :third_holding], to: :recall
    end
    event :to_third_holding do
      transitions from: [:for_sale, :locking, :book, :deposited, :contract_signed, :recall], to: :third_holding
    end
    event :to_third_sold do
      transitions from: [:for_sale, :locking, :book, :deposited, :contract_signed, :recall, :third_holding], to: :third_sold
    end
  end

  # ================================================== #

  def stream_product
    state_text_website = {
      'for_sale' => 'Còn hàng',
      'locking' => 'Đã giữ',
      'book' => 'Đã giữ',
      'deposited' => 'Đã giữ',
      'contract_signed' => 'Đã giữ',
      'sold' => 'Đã bán',
      'recall' => 'Chưa ra hàng',
      'third_holding' => 'Đã giữ',
      'locking_display' => 'Đã giữ',
      'third_sold' => 'Đã bán'
    }
    ActionCable.server.broadcast "stream_product_channel",
                                 {
                                   id: id,
                                   slug: slug,
                                   code: code,
                                   state: state,
                                   state_label: state_text_website[state],
                                   acreage: helpers.acreage(acreage),
                                   direction: Constant::PRODUCT_DIRECTIONS[direction],
                                   bedroom: product_type,
                                   price: helpers.currency(price),
                                   sum_price: helpers.currency(sum_price),
                                   available_products: 100
                                 }
  end

  def action_after_transition
    case aasm.current_event
    when :to_for_sale
      send_notify_state_change
    when :to_recall
      deposits.where.not(state: :canceled).each do |d|
        d.cancel
        d.notes.new content: I18n.t("deposit.messages.product_recall"), created_by_id: User.current.id
        d.save
      end
      send_notify_state_change
    when :to_third_holding
      send_notify_state_change
    when :third_holding_to_sold
      send_notify_state_change
    end
  end

  def send_notify_state_change
    message = "Sản phẩm <strong>#{code}</strong> - <strong>#{project_name}</strong> đã chuyển sang trạng thái <strong>#{I18n.t("product.states.#{aasm.to_state}")}</strong>"
    # TODO: vì không tìm thấy user khi hủy bằng job
    # User.current.notifications.create content: message, related_url: edit_admin_project_product_path(project, self)
  end

  def next_states
    # TODO: check permission
    Product.aasm.events.map do |event|
      transitions = event.instance_variable_get("@transitions")
      {
        from: transitions.map { |t| t.opts[:from] }.flatten.uniq,
        to: transitions.map { |t| t.opts[:to] }.flatten.uniq
      }
    end.map do |state|
      state[:from].include?(aasm.current_state) ? state[:to] : nil
    end.flatten.compact.uniq
  end

  def deposit_checked?
    return true
    deposits.pluck(:state) & case aasm.current_event
                             when :for_sale_to_locking
                               [:request_lock]
                             when :locking_to_locked
                               [:locked, :request_book]
                             when :locked_to_deposited
                               [:deposited]
                             when :deposited_to_booked
                               [:booked, :contract_signed]
                             when :booked_to_sold
                               [:completed]
                             end.present?
  end

  def execute_state_change to_state
    return if state == to_state
    event = if [:for_sale, :recall, :third_holding, :third_sold].include? to_state.to_sym
              "to_#{to_state}"
            else
              "#{state}_to_#{to_state}"
            end
    send(event) if respond_to?(event)
  end

  def acreage
    level == 0 ? carpet_area : plot_area
  end

  def get_real_estate_type
    real_estate_types = []
    Constant::PROJECT_REAL_ESTATE_TYPE.values_at(*real_estate_type).each do |real_estate_type|
      real_estate_types << real_estate_type
    end
    real_estate_types.join(', ')
  end

  def get_state
    I18n.t("product.states.#{self.aasm.current_state}")
  end

  def self.states
    Product.aasm.states.map do |state|
      [I18n.t("product.states.#{state}"), state.name.to_s]
    end.uniq
  end

  private

  def helpers
    @helpers ||= Class.new do
      #include ActionView::Helpers::NumberHelper
      include ApplicationHelper
      include NumberFormatHelper
    end.new
  end

  def delete_division_nil
    if self.floor_id == nil
      division = self.block
      layout = Layout.where(block_id: division.id).first
      product_code = self.code.gsub(division.name, '')
    else
      division = self.floor
      layout = Layout.where("?=ANY(floor_ids)", division.id).first
      product_code = self.code.gsub("#{self.block.name}#{division.name}", '')
    end
    coordinate = Coordinate.find_by(layout_id: layout&.id, product_code: product_code)
    if coordinate
      coordinate.destroy
    end
  end

  def validation_action
    if self.state_changed? && %w(sold third_sold).include?(state_was)
      errors.add(:state, "Không thể thay đổi trạng thái của sản phẩm đã ở trạng thái \"#{I18n.t("product.states.#{state_was}")}\"")
    end
  end

  def after_save_action
    if saved_change_to_state?
      # CĐT Thu hồi or Sàn khác giữ or Đã bán bởi sàn khác
      if %w(recall third_holding third_sold).include?(state)
        NotificationService.product_recall_third_holding_third_sold self
        self.deals.where('deals.state': %w(lock confirm book deposit contract_signed completed)).update_all({ product_id: nil, state: 'lock' })
      end
      # Sàn khác giữ hoặc Thu hồi =>>> Còn hàng
      state_prev = previous_changes['state'].first
      if %w(recall third_holding).include?(state_prev) && state == 'for_sale'
        NotificationService.product_change_for_sale self
      end
    end
  end

end
