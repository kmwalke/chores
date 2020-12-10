FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "role#{n}" }
    description { 'this is a role description' }
    permissions { [] }

    factory :role_admin do
      permissions { Permission.all }
    end
  end
end
