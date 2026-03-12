puts "Cleaning database..."
Car.destroy_all

puts "Creating 100 cars..."

100.times do
  Car.create!(
    make:        FFaker::Vehicle.make,
    model:       FFaker::Vehicle.model,
    year:        rand(2010..2024),
    price:       rand(5000..85000),
    odometer:    rand(100..250000),
    description: FFaker::Lorem.paragraph(2),
    color: FFaker::Color.name
  )
end

puts "Done! Created #{Car.count} cars."
