FactoryBot.define do
  factory :action do
    sequence(:name) { |n| "action#{n}" }
  end
end
