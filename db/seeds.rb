# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




# Countries

Country.create(name: 'Japan')
Country.create(name: 'Tibet')
Country.create(name: 'Peru')
Country.create(name: 'Philippines')
Country.create(name: 'Bosnia')
Country.create(name: 'Herzegovina')
Country.create(name: 'Mozambique')

User.create(first_name: 'George', last_name: 'Jeffries', service: 'Plumbing', email: 'Jeffries@abc.com', country_id: 2, price: 500, password:'password')
User.create(first_name: 'Jane', last_name: 'Yelland', service: 'English Teaching', email: 'Jane@abc.com', country_id: 5, price: 390, password:'password')
User.create(first_name: 'Akita', last_name: 'Yamamoto', service: 'Gardening', email: 'akita@abc.com', country_id: 1, price: 400, password:'password')
User.create(first_name: 'Sumi', last_name: 'Sempurna', service: 'Cheffing', email: 'perfection@abc.com', country_id: 3, price: 5000, password:'password')
User.create(first_name: 'Mila', last_name: 'Milo', service: 'Comedy', email: 'milomonstermayhem@abc.com', country_id: 0, price: 900, password:'password')
User.create(first_name: 'Freedom', last_name: 'Fighter', service: 'Rebellion', email: 'TheRevolt@abc.com', country_id: 4, price: 0, password:'password')
User.create(first_name: 'Erikson', last_name: 'Sony', service: 'Coming out of Retirement', email: 'sonyE@abc.com', country_id: 6, price: 200, password:'password')

