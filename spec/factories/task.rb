FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task#{n}" }
    user
    frequency { 1 }
    size { 1 }
  end
end
