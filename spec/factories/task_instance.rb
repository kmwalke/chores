FactoryBot.define do
  factory :task_instance do
    task
    completed? { false }
    completed_at { nil }
  end
end
