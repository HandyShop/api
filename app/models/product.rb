# frozen_string_literal: true
class Product < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: true

  belongs_to :market
end
