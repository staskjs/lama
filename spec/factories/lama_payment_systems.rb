FactoryGirl.define do
  factory :lama_payment_system, class: 'Lama::PaymentSystem' do
    name { Faker::Company.name }
    active false
    description { Faker::Lorem.paragraph }
  end
end
