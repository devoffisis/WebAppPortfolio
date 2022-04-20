FactoryBot.define do
  factory :user do
    name {"foobar"}
    email {"foo@example.co.jp"}
    password {"123456"}
    password_confirmation {"#{password}"}
  end
end
