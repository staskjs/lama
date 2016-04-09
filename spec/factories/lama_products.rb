FactoryGirl.define do
  factory :lama_product, class: 'Lama::Product' do
    name { Faker::Name.name }
    code { Faker::Lorem.word }
    active true
    active_from { 1.year.ago }
    active_to { 1.year.from_now }
  end
end
