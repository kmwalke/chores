FactoryBot.define do
  factory :permission do
    sequence(:name) { |n| "feature#{n}" }
    description { 'this is a feature description' }
  end
end
