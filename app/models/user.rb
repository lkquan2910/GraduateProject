class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  enum account_type: [:internal, :investor, :agent]

  # Validations
  validates :email, presence: true
  validates :password, presence: true,
            confirmation: true,
            length: {within: 6..40},
            on: :create
  validates :password, confirmation: true,
            length: {within: 6..40},
            allow_blank: true,
            on: :update
  validates :full_name, presence: true

  def send_password_reset
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end

  def super_admin?
    self.is_superadmin === true || false
  end
end
