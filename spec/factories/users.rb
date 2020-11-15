FactoryBot.define do
  factory :user do
    name { "user" }
    sequence(:email) { |n| "user#{n}@examle.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
