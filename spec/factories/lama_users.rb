FactoryGirl.define do
  factory :lama_user, class: 'Lama::User' do
    factory :shadowed_lama_user do
      shadow true
    end
  end
end
