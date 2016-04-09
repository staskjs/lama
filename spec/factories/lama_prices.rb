FactoryGirl.define do
  factory :lama_price, class: 'Lama::Price' do
    price { Faker::Number.decimal(2) }
  end
end
