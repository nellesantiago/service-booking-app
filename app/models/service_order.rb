class ServiceOrder < ApplicationRecord
  belongs_to :order
  belongs_to :service

  def total
    service.price * quantity
  end
end
