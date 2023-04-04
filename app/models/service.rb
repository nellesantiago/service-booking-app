class Service < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  has_many :service_orders, dependent: :destroy
  has_many :orders, through: :service_orders

  has_one_attached :image

  before_save :format_data

  validates_presence_of :details, :price, :service_type
  validates :name, presence: true, length: { in: 1..20 }
  validates :image, presence: true

  validates_numericality_of :price, greater_than: 0, less_than: 10000

  enum service_type: {service: 0, add_on: 1}

  def format_data
    self.name = self.name.capitalize
  end
end
