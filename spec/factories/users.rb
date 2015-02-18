FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'Spacken123'
    password_confirmation 'Spacken123'
  end
end
