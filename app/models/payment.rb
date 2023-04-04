class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  enum payment_type: {cash: 0, card: 1}
  enum payment_status: {unpaid: 0, paid: 1}
end
