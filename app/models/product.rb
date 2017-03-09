class Product < ApplicationRecord
  validates :name, :quantity, :price, presence: true
  validates :price, numericality: true
end
