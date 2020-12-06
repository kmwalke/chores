FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "role#{n}" }
    description { 'this is a role description' }

    transient do
      permissions_count { 2 }
    end

    permissions do
      Array.new(permissions_count) do
        association(:permission, roles: [instance])
      end
    end
  end
end
