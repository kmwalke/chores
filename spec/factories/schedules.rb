FactoryBot.define do
  factory :schedule do
    occurrences { 2 }
    due_date { 1.week.since }
    model_type { 'Task' }
    association :model, factory: :task
  end
end
