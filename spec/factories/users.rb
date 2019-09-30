FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "test@test.org" }
    description { "Lorem ipsum foda-se" }
    password { "test123" }
    password_confirmation { "test123" }
    password_digest { "Hash" }
  end
end
