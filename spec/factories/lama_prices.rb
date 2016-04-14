FactoryGirl.define do
  factory :lama_price, class: 'Lama::Price' do
    price { Faker::Commerce.price }
  end
end
