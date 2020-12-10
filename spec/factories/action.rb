FactoryBot.define do
  factory :action do
    sequence(:name) { |n| "feature#{n}" }
  end
end
