class PaymentSchedule < ApplicationRecord
  # Associations
  belongs_to :project
  # Validations
  validates :name, :label_schedule, presence: true
  validates :pay, numericality: { greater_than: 0, less_than_or_equal_to: 100 }, presence: true

  scope :policy_high_level, -> {where label_schedule: 0}
  scope :policy_low_level, -> {where label_schedule: 1}
end
