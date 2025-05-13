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
%w[current_user features permissions rewards roles tasks users].each do |name|
  permissions[name.to_sym] = Permission.create(feature: Feature.create(name: name), actions: Action.all)
end

admin_role = Role.create(name: 'Admin', description: 'an admin')
user_role  = Role.create(name: 'User', description: 'a user')

admin_role.permissions << Permission.all
user_role.permissions << [permissions[:current_user], permissions[:tasks]]

User.create(name: 'admin1', email: 'admin@chores.com', role: admin_role, password: '123', time_zone: 'MST')
User.create(name: 'user1', email: 'user1@chores.com', role: user_role, password: '123', time_zone: 'MST')
User.create(name: 'user2', email: 'user2@chores.com', role: user_role, password: '123', time_zone: 'MST')
User.create(name: 'user3', email: 'user3@chores.com', role: user_role, password: '123', time_zone: 'MST')

['clean', 'workout', 'play music', 'walk the dog', 'empty litter box', 'go to playground', 'build something',
 'learn something', 'homework', 'shop', 'cook', 'dishes'].each do |name|
  User.find_each do |user|
    Task.create(user: user, name: name, size: rand(1..5), frequency: rand(1..7))
  end
end

['ice cream', 'banjo strings', 'new shoes', 'new game', 'lazy day', 'get drunk'].each do |name|
  User.find_each do |user|
    Reward.create(name: name, user: user)
  end
end
