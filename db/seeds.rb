require 'faker'

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Create 20 Beds

20.times do
  # owner = User.all.sample(1).first
  bed = Bed.new({
    name:      Faker::Book.title,
    category:  [:hutte, :marais, :autre].sample(1).first,
    street:    Faker::Address.street_address,
    zipcode:   Faker::Address.zip_code,
    city:      Faker::Address.city,
    price:     rand(100..1000),
    owner_id:  [1, 2, 3].sample(1).first,
    picture:   'http://unsplash.it/800?random'
  })

  bed.save

end
