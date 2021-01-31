FactoryBot.define do
  factory :schedule do
    occurrences { 2 }
    due_date { 1.week.since }
    model_type { 'Task' }

    factory :schedule_with_reward do
      association :model, factory: :reward
    end

    factory :schedule_with_task do
      association :model, factory: :task
    end
  end
end
