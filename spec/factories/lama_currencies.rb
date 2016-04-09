FactoryGirl.define do
  factory :lama_currency, class: 'Lama::Currency' do
    name { Faker::Lorem.word }
    numcode { Faker::Lorem.characters(4) }
    base true
  end
end
