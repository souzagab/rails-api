FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "test@test.org" }
    description { "Lorem ipsum foda-se" }
    password_digest { "Hash" }
  end
end
