FactoryGirl.define do
  factory :lama_product, class: 'Lama::Product' do
    name { Faker::Commerce.product_name }
    active true
    active_from { 1.year.ago }
    active_to { 1.year.from_now }
    preview_picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'files', 'sample.jpg')) }
  end
end
