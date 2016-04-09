FactoryGirl.define do
  factory :lama_price_type, class: 'Lama::PriceType' do
    name { Faker::Lorem.word }
    base false
  end
end
