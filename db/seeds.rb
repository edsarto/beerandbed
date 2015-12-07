require 'faker'

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Create 20 Beds

20.times do
  # owner = User.all.sample(1).first
  bed = Bed.new({
    name:      Faker::Book.title,
    category:  [:bed, :couch, :other].sample(1).first,
    street:    Faker::Address.street_address,
    zipcode:   Faker::Address.zip_code,
    city:      Faker::Address.city,
    price:     rand(10..50),
    owner_id:  rand(1..2),
    picture:   'http://unsplash.it/800?random'
  })

  bed.save!

end
