FactoryGirl.define do
  factory :market do
    name 'Tested Market'
  end
  
  factory :second_market, class: Market do
    name 'Another Market'
  end
  
  factory :invalid_market, class: Market do
    name nil
  end
end