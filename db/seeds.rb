# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: "sulman1990@hotmail.com", password: "Android89", password_confirmation: "Android89", admin: true)
User.create(email: "waqarbaig85@gmail.com", password: "Android89", password_confirmation: "Android89", admin: false)

p "2 Users created"
