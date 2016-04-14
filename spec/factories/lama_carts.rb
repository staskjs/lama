FactoryGirl.define do
  factory :lama_cart, class: 'Lama::Cart' do
    price { Faker::Commerce.price }
    name { Faker::Commerce.department }
    quantity { Faker::Number.between(1, 5) }
    discount_price { Faker::Commerce.price }
  end
end
