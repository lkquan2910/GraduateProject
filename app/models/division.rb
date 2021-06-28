class Division < ApplicationRecord

  # Associations
  has_many :childrens, class_name: "Division", foreign_key: :parent_id
  belongs_to :parent, class_name: "Division", optional: true
  belongs_to :project, optional: true
  has_many :floor_products, class_name: "Product", foreign_key: :floor_id
  has_many :block_products, class_name: "Product", foreign_key: :block_id
  #has_one :interactive_layout, dependent: :destroy

  # Validations
  validates :name, presence: true

end
