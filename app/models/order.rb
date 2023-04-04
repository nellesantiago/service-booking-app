class Order < ApplicationRecord
  belongs_to :time_slot
  has_one :booking, dependent: :destroy

  has_many :service_orders, dependent: :destroy
  has_many :services, through: :service_orders

  def highest_quantity
    service_orders.select {|order| order.service.service_type == "service"}.maximum(:quantity)
  end

  def category
    services.first.category.name
  end

  def total
    service_orders.to_a.sum {|order| order.total}
  end
end
