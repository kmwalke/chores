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

admin_role = Role.create(name: 'Admin')
user_role  = Role.create(name: 'User')

admin_role.permissions << Permission.all
user_role.permissions << [permissions[:tasks]]

admin = User.create(name: 'admin1', email: 'admin@chores.com', role: admin_role, password: '123')
user1 = User.create(name: 'user1', email: 'user1@chores.com', role: user_role, password: '123')
user2 = User.create(name: 'user2', email: 'user2@chores.com', role: user_role, password: '123')
user3 = User.create(name: 'user3', email: 'user3@chores.com', role: user_role, password: '123')

%w[clean workout play\ music walk\ the\ dog
   empty\ litter\ box go\ to\ playground
   build\ something learn\ something
   homework shop cook dishes].each do |name|
  Task.create(user: admin, name: name, size: rand(1..5), frequency: rand(1..7))
  Task.create(user: user1, name: name, size: rand(1..5), frequency: rand(1..7))
  Task.create(user: user2, name: name, size: rand(1..5), frequency: rand(1..7))
  Task.create(user: user3, name: name, size: rand(1..5), frequency: rand(1..7))
end
