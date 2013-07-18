# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = User.create(email: "a@a.com", password: "a")
User.create(email: "b@b.com", password: "a")
User.create(email: "c@c.com", password: "a")

a.addresses.create(name: "HiThere", city: "San Francisco", number_and_street: "414 Brannan", zip_code: "94107", state: "CA") 

a.addresses.create(name: "Yeah", city: "San Francisco", number_and_street: "535 Linden Street", zip_code: "94102", state: "CA") 


