# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin1 = Guest.create(firstname: "Kenny", lastname: "Duong", email: "keduong@gmail.com", admin: true, sitekey: "kenny")
admin1.password = "bananas"
admin1.save

admin2 = Guest.create(firstname: "Lauren", lastname: "Jones", email: "laurensjones@gmail.com", admin: true, sitekey: "lauren")
admin2.password = "bananas"
admin2.save
