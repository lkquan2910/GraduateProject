class Development < ApplicationRecord
  include GeneralSearch

  mount_uploader :logo, LogoUploader

  # Validations
  validates :name ,presence: true
  validates :description ,presence: true
  # validates :logo, presence: true

  def projects
    Project.where('constructors @> ARRAY[?]::integer[]', [id])
  end
end