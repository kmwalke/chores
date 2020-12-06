FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    email { "#{name}@chores.com".downcase }
    password { '123' }
    role
  end
end
