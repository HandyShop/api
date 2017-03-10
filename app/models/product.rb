class Product < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true, numericality: true

  belongs_to :market
end
