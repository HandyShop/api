class Market < ApplicationRecord
  validates :name, presence: true

  has_many :products
end
