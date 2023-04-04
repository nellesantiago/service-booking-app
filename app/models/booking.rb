class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_one :payment, dependent: :destroy
  before_save :format_data

  validates_presence_of :first_name, :last_name, :mobile_number, :street, :barangay, :city, :province, :postal_code

  validates :mobile_number, format: { with: /\A(09)\d{9}\z/ }

  validates_length_of :postal_code, maximum: 4
  validates_length_of :first_name, maximum: 20
  validates_length_of :last_name, maximum: 20
  validates_length_of :street, maximum: 50
  validates_length_of :barangay, maximum: 50
  validates_length_of :city, maximum: 50
  validates_length_of :province, maximum: 50

  enum status: { pending: 0, upcoming: 1, done: 2 }

  def format_data
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
    self.street = self.street.capitalize
    self.barangay = self.barangay.capitalize
    self.city = self.city.capitalize
    self.province = self.province.capitalize
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
