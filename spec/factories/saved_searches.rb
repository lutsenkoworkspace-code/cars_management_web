FactoryBot.define do
  factory :saved_search do
    user { nil }
    name { "MyString" }
    query_params { "MyText" }
  end
end
