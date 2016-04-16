FactoryGirl.define do
  factory :lama_person_type, :class => 'Lama::PersonType' do
    name { Faker::Lorem.word }
    active true
  end

end
