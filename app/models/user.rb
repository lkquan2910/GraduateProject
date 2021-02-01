class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  enum account_type: [:internal, :investor, :agent]

  # Validations
  validates :email, presence: true
  validates :password, presence: true

end
