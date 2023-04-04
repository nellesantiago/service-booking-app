class Category < ApplicationRecord
  has_many :services, dependent: :destroy
  has_many :time_slots, dependent: :destroy
  has_one_attached :image
  
  validates :description, presence: :true, length: { in: 1..200 }
  validates :name, presence: true, length: { in: 1..20 }
  validates :image, presence: true

  before_save :format_data

  def format_data
    self.name = self.name.capitalize
  end
end
