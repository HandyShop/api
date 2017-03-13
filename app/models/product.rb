# frozen_string_literal: true
class Product < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true, numericality: true
end
