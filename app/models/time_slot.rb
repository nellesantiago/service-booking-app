class TimeSlot < ApplicationRecord
  belongs_to :category
  has_many :orders, dependent: :destroy

  def available(date, cart)
    @orders = orders.where(date: date)
    @slots = @orders.to_a.sum { |order| order.highest_quantity }
    @pending_slots = @slots + cart.slots
    @available_slots = max_slot - @pending_slots
    @available_slots >= 0
  end
end
