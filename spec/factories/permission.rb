FactoryBot.define do
  factory :permission do
    feature

    transient do
      actions_count { 2 }
    end

    actions do
      Array.new(actions_count) do
        association(:action, permissions: [instance])
      end
    end
  end
end
