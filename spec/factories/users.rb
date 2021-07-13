FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 4) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    profile               { Faker::Lorem.sentence }
    after(:build) do |user|
      user.image.attach(io: File.open('public/image/test-image.jpg'), filename: 'test-image.jpg')
    end
  end
end
