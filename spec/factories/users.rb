FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    after(:build) do |user|
      user.image.attach(io: File.open('public/image/test-image.jpg'), filename: 'test-image.jpg')
    end
  end
end
