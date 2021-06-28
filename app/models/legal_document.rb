class LegalDocument < ApplicationRecord

  mount_uploader :doc, LegalDocumentUploader

  # Associations
  belongs_to :project

  # Validations
  validates :doc_type, presence: true
  validates :doc, presence: true
end
