FactoryBot.define do
  factory :task_instance do
    task
    completed_at { nil }
  end
end
