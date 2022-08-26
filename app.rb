# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'
require_relative 'lib/recipe'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory_test')

cookbook = RecipeRepository.new
cookbook.primitive_all
cookbook.universal_all(true, true)
cookbook.universal_all(true, false)
cookbook.universal_all(false, true)
cookbook.universal_all(false, false)
cookbook.find(18, 1)
cookbook.find(nil, 0)

# # Perform a SQL query on the database and get the result set.
# sql = 'SELECT * FROM recipes;'
# result = DatabaseConnection.exec_params(sql, [])

# # Print out each record from the result set .
# result.each do |recipe|
#     p recipe
# end