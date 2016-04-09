FactoryGirl.define do
  factory :lama_currency, class: 'Lama::Currency' do
    name { Faker::Lorem.word }
    base true
  end
end
