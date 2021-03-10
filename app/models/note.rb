class Note < ApplicationRecord
  #include WriteHistory
  #acts_as_paranoid
  # Associations
  belongs_to :objectable, polymorphic: true, optional: true
  belongs_to :author, class_name: 'User', foreign_key: :created_by_id, required: false
  belongs_to :customer, class_name: 'Customer', foreign_key: :created_by_id, required: false
  belongs_to :deal, foreign_key: :objectable_id, foreign_type: 'Deal'
  # Validations
  validates :content, presence: true
end
