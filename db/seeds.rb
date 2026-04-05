puts "Cleaning database..."
User.destroy_all
Car.destroy_all

puts "Creating Admin user..."
User.create!(
  full_name: "Admin Test",
  email: "admin@test.com",
  password: "88888888",
  password_confirmation: "88888888",
  role: "admin"
)
puts "Admin created: admin@test.com / 88888888"

puts "Creating 100 cars..."
100.times do
  Car.create!(
    make:        FFaker::Vehicle.make,
    model:       FFaker::Vehicle.model,
    year:        rand(2010..2024),
    price:       rand(5000..85000),
    odometer:    rand(100..250000),
    description: FFaker::Lorem.paragraph(2),
    color:       FFaker::Color.name
  )
end

puts "Done! Total Users: #{User.count}, Total Cars: #{Car.count}"
