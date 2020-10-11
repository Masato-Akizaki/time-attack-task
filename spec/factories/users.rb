FactoryBot.define do
  factory :user do
    name { "user" }
    email { "user@examle.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
