FactoryBot.define do
  factory :permission do
    feature

    transient do
      actions_count { 2 }
    end

    actions do
      Action.all.to_a
    end
  end
end
