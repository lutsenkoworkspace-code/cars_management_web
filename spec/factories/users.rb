FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    full_name { "Test User" }
    role { :user }

    trait :admin do
      role { :admin }
    end
  end
end
