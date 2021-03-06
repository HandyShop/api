# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :quantity }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :price }
  it { is_expected.to validate_numericality_of(:quantity).only_integer }
  it { is_expected.to belong_to :market }
end
