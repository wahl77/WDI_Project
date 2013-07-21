# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Item.destroy_all
Location.destroy_all
Address.destroy_all
Category.destroy_all

%w( General Rentals Neighborliness Travel Education Pets Events Jobs Recommendations Restaurant Bar ).each do |x| 
  Category.create(name: x)
end

a = User.create(email: "a@a.com", password: "a")
b = User.create(email: "b@b.com", password: "a")
User.create(email: "c@c.com", password: "a")

a.addresses.create(name: "HiThere", city: "San Francisco", number_and_street: "414 Brannan", zip_code: "94107", state: "CA") 

b.addresses.create(name: "Yeah", city: "San Francisco", number_and_street: "535 Linden Street", zip_code: "94102", state: "CA") 
b.addresses.create(name: "Janes", city: "New York", number_and_street: "251 West 98 Street", zip_code: "10025", state: "NY") 


25.times do |x|
  item = Item.create(name: "Item#{x}")
  b.items << item
  item.categories << Category.first
  loc = a.addresses.last.location.dup
  item.location = loc
end

