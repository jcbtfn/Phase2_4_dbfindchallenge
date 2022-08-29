# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'
require_relative 'lib/recipe'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory_test')

cookbook = RecipeRepository.new
cookbook.primitive_all
puts "First Test - All the information from the recipe"
cookbook.universal_all(true, true)
puts "Second Test - With Average Cooking Time but no rating"
cookbook.universal_all(true, false)
puts "Second Test - Without Average Cooking Time but with the rating"
cookbook.universal_all(false, true)
puts "Second Test - Only ID and recipe name"
cookbook.universal_all(false, false)
puts "Recipe for less than 18 minutes and more than 1*"
cookbook.find(18, 1)
puts "Testing passing nil and 0"
cookbook.find(nil, 0)

# # Perform a SQL query on the database and get the result set.
# sql = 'SELECT * FROM recipes;'
# result = DatabaseConnection.exec_params(sql, [])

# # Print out each record from the result set .
# result.each do |recipe|
#     p recipe
# end