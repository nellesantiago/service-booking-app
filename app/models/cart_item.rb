class CartItem < ApplicationRecord
  belongs_to :service
  belongs_to :cart

  validates_numericality_of :quantity, greater_than: -1

  def total
    service.price * quantity
  end
end
