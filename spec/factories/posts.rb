FactoryBot.define do
  factory :post do
    caption {'caption'}
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.png'))}
    association :user
  end
end
