FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    email { "#{name}@chores.com".downcase }
    password { '123' }
    role

    factory :user_with_tasks do
      transient do
        tasks_count { 20 }
        rewards_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:task, evaluator.tasks_count, user: user)
        create_list(:reward, evaluator.rewards_count, user: user)
      end
    end
  end
end
