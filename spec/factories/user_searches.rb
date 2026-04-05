FactoryBot.define do
  factory :user_search do
    user { nil }
    name { "MyString" }
    query_params { "MyText" }
  end
end
