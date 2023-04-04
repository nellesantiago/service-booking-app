class User < ApplicationRecord
    has_secure_password
    has_one :cart, dependent: :destroy
    has_many :bookings, dependent: :destroy
    has_many :orders, through: :bookings
    has_many :payments, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    before_save :format_data
  
    validates :password, presence: true, length: { in: 6..20 }, allow_nil: true
  
    enum role: { customer: 0, admin: 1 }
  
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    def format_data
      self.email = self.email.downcase
    end
  end