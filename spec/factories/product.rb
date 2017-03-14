FactoryGirl.define do
  factory :product do
    name 'Tested Product'
    price 1.99
    quantity 3
    description "Product's description"
    barcode '4242424242'
  end
  
  factory :second_product, class: Product do
    name 'Another Market'
    price 3.57
    quantity 9
    description "Updated description"
    barcode '147258'
  end
  
  factory :invalid_product, class: Product do
    name nil
    price nil
    quantity nil
    description nil
    barcode nil
  end
end