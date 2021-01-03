FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task#{n}" }
    user
    frequency { 1 }
    size { 1 }

    transient do
      task_instances_count { 20 }
    end

    after(:create) do |task, evaluator|
      create_list(:task_instance, evaluator.task_instances_count, task: task)
    end
  end
end
