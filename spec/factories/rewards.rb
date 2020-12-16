FactoryBot.define do
  factory :reward do
    sequence(:name) { |n| "reward#{n}" }
    user
  end
end
