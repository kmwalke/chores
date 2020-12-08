FactoryBot.define do
  factory :permission do
    sequence(:name) { |n| "permission#{n}" }
    description { 'this is a permission description' }
    feature

    # transient do
    #   actions_count { 2 }
    # end
    #
    # actions do
    #   Array.new(actions_count) do
    #     association(:action, permissions: [instance])
    #   end
    # end
  end
end
