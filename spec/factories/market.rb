FactoryGirl.define do
  factory :market do
    name { Faker::Name.name }
  end

  factory :second_market, class: Market do
    name { Faker::Name.name }
  end

  factory :invalid_market, class: Market do
    name nil
  end
end
