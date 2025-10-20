# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin user
puts "Creating admin user..."
admin = User.find_or_create_by!(email: 'admin@studychain.com') do |user|
  user.name = 'Admin'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :admin
end
puts "Admin user created: #{admin.email} (password: password123)"

# Create sample premium user
puts "Creating premium user..."
premium = User.find_or_create_by!(email: 'premium@studychain.com') do |user|
  user.name = 'Premium User'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :premium
end
puts "Premium user created: #{premium.email} (password: password123)"

# Create sample normal user
puts "Creating normal user..."
normal = User.find_or_create_by!(email: 'user@studychain.com') do |user|
  user.name = 'Normal User'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :normal
end
puts "Normal user created: #{normal.email} (password: password123)"

puts "Seeding completed!"
