FactoryGirl.define do
  factory :lama_delivery_system, class: 'Lama::DeliverySystem' do
    name { Faker::Company.name }
    active false
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price }
  end
end
