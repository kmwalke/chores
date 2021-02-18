FactoryBot.define do
  factory :permission do
    feature
    actions { Action.all.to_a }
  end
end
