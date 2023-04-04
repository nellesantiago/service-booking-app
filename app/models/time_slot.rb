class TimeSlot < ApplicationRecord
  belongs_to :category
  has_many :orders, dependent: :destroy

  validates_presence_of :time, :max_slot

  validates_length_of :max_slot, maximum: 1

  validate :duplicate_time_slot, on: :create

  def available(date, cart)
    @orders = orders.where(date: date)
    @slots = @orders.to_a.sum { |order| order.highest_quantity.to_i }
    @pending_slots = @slots + cart.slots
    @available_slots = max_slot - @pending_slots
    @available_slots >= 0
  end

  def duplicate_time_slot
    return unless self.category
    if self.category.time_slots.where(time: self.time).any?
      errors.add(:time, "already exists")
    end
  end
end
