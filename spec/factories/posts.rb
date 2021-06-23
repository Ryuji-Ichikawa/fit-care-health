FactoryBot.define do
  factory :post do
    title       { Faker::Name.initials(number: 6) }
    catch_copy  { Faker::Lorem.sentence }
    concept     { Faker::Lorem.sentence }
    after(:build) do |post|
      post.image.attach(io: File.open('public/image/test-image.jpg'), filename: 'test-image.jpg')
    end
    association :user
  end
end
