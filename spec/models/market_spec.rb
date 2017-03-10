require 'rails_helper'

RSpec.describe Market, type: :model do
  
  it { should validates_presence_of :name}

end
