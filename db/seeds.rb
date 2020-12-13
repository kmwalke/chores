# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Action::NAMES.each do |action|
  Action.create(name: action)
end

permissions = {}
%w[features permissions roles tasks users].each do |name|
  permissions[name.to_sym] = Permission.create(feature: Feature.create(name: name), actions: Action.all)
end

admin  = Role.create(name: 'Admin')
user = Role.create(name: 'User')

admin.permissions << Permission.all
user.permissions << [permissions[:tasks]]

User.create(name: 'admin1', email: 'admin@chores.com', role: admin, password: '123')
User.create(name: 'user1', email: 'user1@chores.com', role: user, password: '123')
User.create(name: 'user2', email: 'user2@chores.com', role: user, password: '123')
