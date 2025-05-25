# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'

puts "Clearing existing data..."
Product.destroy_all

# Create categories for more realistic product names
CATEGORIES = [
  ['Electronics', ['Smartphones', 'Laptops', 'Headphones', 'Tablets', 'Smartwatches']],
  ['Fashion', ['T-shirts', 'Jeans', 'Dresses', 'Shoes', 'Accessories']],
  ['Home', ['Furniture', 'Decor', 'Kitchen', 'Bedding', 'Lighting']],
  ['Sports', ['Equipment', 'Clothing', 'Shoes', 'Accessories', 'Nutrition']],
  ['Books', ['Fiction', 'Non-fiction', 'Educational', 'Comics', 'Children']]
]

# Predefined image URLs for each category
IMAGES = {
  'Electronics' => [
    'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&w=800&h=800&q=80'
  ],
  'Fashion' => [
    'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&w=800&h=800&q=80'
  ],
  'Home' => [
    'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1513161455079-7dc1de15ef3e?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1556911220-bff31c812dba?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1507089947368-19c1da9775ae?auto=format&fit=crop&w=800&h=800&q=80'
  ],
  'Sports' => [
    'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1518604693757-fe9c2726052f?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1535131749006-b7f58c99034b?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?auto=format&fit=crop&w=800&h=800&q=80'
  ],
  'Books' => [
    'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1524578271613-d550eacf6090?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&h=800&q=80',
    'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&h=800&q=80'
  ]
}

# Create 100 products
puts 'Creating products...'

100.times do |i|
  # Pick a random category and subcategory
  category, subcategories = CATEGORIES.sample
  subcategory = subcategories.sample
  
  # Generate a realistic product name
  product_name = case category
  when 'Electronics'
    "#{Faker::Company.name} #{subcategory} #{Faker::Number.decimal_part(digits: 3)}"
  when 'Fashion'
    "#{Faker::Color.color_name.capitalize} #{subcategory} #{Faker::Lorem.word.capitalize}"
  when 'Home'
    "#{Faker::Company.buzzword.capitalize} #{subcategory}"
  when 'Sports'
    "#{Faker::Company.name} #{subcategory} Pro"
  when 'Books'
    Faker::Book.title
  end

  # Generate a realistic description
  description = case category
  when 'Electronics'
    "#{Faker::Company.buzzword.capitalize}! This #{subcategory.downcase} features #{Faker::Lorem.sentence(word_count: 8)} with #{Faker::Lorem.words(number: 3).join(', ')}."
  when 'Fashion'
    "#{Faker::Company.buzzword.capitalize} #{subcategory.downcase}. #{Faker::Lorem.sentence(word_count: 6)} Perfect for #{Faker::Lorem.words(number: 2).join(' and ')}."
  when 'Home'
    "Transform your space with this #{Faker::Company.buzzword.downcase} #{subcategory.downcase}. #{Faker::Lorem.sentence(word_count: 8)}"
  when 'Sports'
    "Elevate your performance with this #{Faker::Company.buzzword.downcase} #{subcategory.downcase}. #{Faker::Lorem.sentence(word_count: 6)}"
  when 'Books'
    Faker::Lorem.paragraph(sentence_count: 3, supplemental: true)
  end

  # Generate a realistic price based on category
  price = case category
  when 'Electronics'
    Faker::Number.between(from: 99.99, to: 1999.99)
  when 'Fashion'
    Faker::Number.between(from: 19.99, to: 199.99)
  when 'Home'
    Faker::Number.between(from: 29.99, to: 499.99)
  when 'Sports'
    Faker::Number.between(from: 9.99, to: 299.99)
  when 'Books'
    Faker::Number.between(from: 4.99, to: 49.99)
  end

  # Get a random image URL for the category
  image_url = IMAGES[category].sample

  # Create the product
  Product.create!(
    name: product_name,
    description: description,
    price: price.round(2),
    image_url: image_url,
    featured: rand < 0.2, # 20% chance to be featured
    active: true
  )

  puts "Created product #{i + 1} of 100: #{product_name}"
end

puts 'Finished creating products!'

# Create admin user
puts "Creating admin user..."
admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'admin'
)
puts "Created admin user: #{admin.email}"
