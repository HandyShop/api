# frozen_string_literal: true
FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    quantity { Faker::Number.between(1, 10) }
    description { Faker::Commerce.product_name }
    barcode { Faker::Commerce.promotion_code }
  end

  factory :invalid_product, class: Product do
    name nil
    price nil
    quantity nil
    description nil
    barcode nil
  end
end
