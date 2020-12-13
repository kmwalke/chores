FactoryBot.define do
  factory :task_instance do
    task_id { 1 }
    completed? { false }
    completed_at { "2020-12-13 16:17:19" }
  end
end
