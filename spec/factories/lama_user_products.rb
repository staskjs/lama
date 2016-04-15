FactoryGirl.define do
  factory :lama_user_products, class: 'Lama::UserProduct' do
    price { Faker::Commerce.price }
    name { Faker::Commerce.department }
    quantity { Faker::Number.between(1, 5) }
    discount_price { Faker::Commerce.price }
  end
end
