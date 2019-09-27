FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    description { "MyText" }
    password_digest { "MyText" }
  end
end
