class Product < ApplicationRecord
  validates :name, :quantity, :price, presence: true
end
