# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p1 = Permission.create(name: 'feature_1', description: 'Feature One')
p2 = Permission.create(name: 'feature_2', description: 'Feature Two')
p3 = Permission.create(name: 'feature_3', description: 'Feature Three')

admin  = Role.create(name: 'Admin')
parent = Role.create(name: 'Parent')
child  = Role.create(name: 'Child')

admin.permissions << [p1, p2, p3]
parent.permissions << [p2, p3]
child.permissions << p3

admin_user = User.create(name: 'user1', email: 'admin@chores.com', role: admin, password: '123')
parent_user = User.create(name: 'user1', email: 'parent@chores.com', role: parent, password: '123')
child_user = User.create(name: 'user1', email: 'child@chores.com', role: child, password: '123')
