FactoryGirl.define do
  factory :lama_user, class: 'Lama::User' do
    email { Faker::Internet.email }
    password '1234567890'

    factory :lama_empty_user do
      email nil
      password nil

      factory :lama_shadowed_user do
        shadow true
      end
    end
  end
end
