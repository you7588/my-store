# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.new
u.email = "123@123.com"

u.password = "123123"

u.password_confirmation = "123123"

u.is_admin = true
u.save


products_categories = ["科技众筹产品", "科技众筹产品","科技众筹产品","科技众筹产品","科技众筹产品"]
create_products = for i in 1..5 do
Product.create!([title: products[i - 1],
description: products_description[i - 1],
quantity: rand(0..10),
price: products_prices[i - 1],
image: File.open(File.join(Rails.root, products_images[i-1])),
categories: products_categories[i-1] ])
end
