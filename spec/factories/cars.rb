FactoryBot.define do
  factory :car do
    make { "MyString" }
    model { "MyString" }
    year { 2000 }
    odometer { 1 }
    price { "9.99" }
    description { "MyText" }
    date_added { "2026-03-08" }
  end
end
