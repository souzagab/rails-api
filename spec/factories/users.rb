FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name }
    email { FFaker::Internet.unique.email }
    description { "Lorem ipsum foda-se" }
    password { "test123" }
    password_confirmation { "test123" }
    password_digest { "Hash" }
  end
end
