class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :services, through: :cart_items

  def total
    cart_items.to_a.sum { |item| item.total }
  end

  def slots
    cart_items.select {|item| item.service.service_type == "service"}.maximum(:quantity)
  end

  def category
    services.uniq.pluck(:category_id)
  end
end
