require 'rails_helper'

RSpec.describe Market, type: :model do
  
  it { should validate_presence_of :name }
  it { should have_many :products }
  
end
