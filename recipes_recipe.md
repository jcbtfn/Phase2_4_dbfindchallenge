{{TABLE NAME}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep a list of all my recipes with their names.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep the average cooking time (in minutes) for each recipe.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to give a rating to each of the recipes (from 1 to 5).

# EXAMPLE

Table: recipes

Columns:
id | name | avg_cooking_time | rating

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/recipe_seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Spanish Omelette', 45, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Green Thai Curry', 30, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Pasta alla Norma', 60, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Egg Fried Rice', 20, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Breaded Mushrooms', 30, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Guacamole', 15, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Lentil Dhal', 60, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Greek Salad', 20, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Fish and Chips', 60, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Green Beans & Bacon', 45, 5);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Gozlehme', 60, 4);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Double Cheeseburger', 10, 3);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Chicken Wings', 15, 2);
INSERT INTO recipes (name, avg_cooking_time, rating) VALUES ('Green Peas', 20, 1);

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 recipes_directory_test < recipe_seeds.sql

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: recipes

# Model recipe
# (in lib/recipe.rb)
class Recipe
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end
4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: recipe

# Model class
# (in lib/recipe.rb)

class Recipe
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :avg_cooking_time, :rating
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: recipes

# Repository class
# (in lib/recipe_repository.rb)

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM recipes;

    # Returns an array of Recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def print_recipenames
    # Executes the SQL query:
    # SELECT name FROM recipes;

    # Returns a list of recipe names.
  end

    def find(cooking_time)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

    def find(rating)
    # Executes the SQL query:
    # SELECT id, name, avg_cooking_time FROM recipes WHERE rating >= num;

    # Returns a list of recipes.
  end



end
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all recipes

repo = RecipeRepository.new

cookbook = repo.all

cookbook.length # =>  14

cookbook[0].id # =>  1
cookbook[0].name # =>  'Spanish Omelette'
cookbook[0].avg_cooking_time # =>  45
cookbook[0].rating # =>  5

cookbook[1].id # =>  2
cookbook[1].name # =>  'Anna'
cookbook[1].avg_cooking_time # =>  30
cookbook[0].rating # =>  5

# 2
# Print list of recipe names

[find - use list created before, look in db and return]

cookbook = repo.all

cookbook.print_names 

List of all the recipe names

Spanish Omelette
Green Thai Curry
Pasta alla Norma
Egg Fried Rice
Breaded Mushrooms
Guacamole
Lentil Dhal
Greek Salad
Fish and Chips
Green Beans & Bacon
Gozlehme
Double Cheeseburger
Chicken Wings
Green Peas

# 3
# Print a list of recipes and times

Gives a list of recipe names with the times

# 4
# Find recipes for a certain amount of time in minutes

Passing the number of minutes availables give back a list of recipes

# 5
# Print a list of recipes and rating

Gives a list of recipe names with the times

# 6
# Find recipes for a certain rate

Passing the rating give back a list of recipes

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).

describe RecipeRepository do

    before(:each) do 
        reset_recipe_table
    end

    it "#Returns the number of recipes in the db (14)" do
        cookbook = RecipeRepository.new
        expect(cookbook.universal_all.length).to eq 14
    end

    it "#Returns the information of recipe 1 - Spanish Omelette 45 minutes 5*" do
        new_cookbook = RecipeRepository.new
        cookbook = new_cookbook.primitive_all
        expect(cookbook[0].id).to eq "1"
        expect(cookbook[0].name).to eq "Spanish Omelette"
        expect(cookbook[0].avg_cooking_time).to eq "45"
        expect(cookbook[0].rating).to eq "5"
    end

    it "#Returns the information of recipe 5 - Breaded Mushrooms 30 minutes 5*" do
        new_cookbook = RecipeRepository.new
        cookbook = new_cookbook.primitive_all
        expect(cookbook[4].id).to eq "5"
        expect(cookbook[4].name).to eq "Breaded Mushrooms"
        expect(cookbook[4].avg_cooking_time).to eq "30"
        expect(cookbook[4].rating).to eq "5"
    end

    it "#Returns the information of recipe 14 - Green Peas 20 minutes 1*" do
        new_cookbook = RecipeRepository.new
        cookbook = new_cookbook.primitive_all
        expect(cookbook[13].id).to eq "14"
        expect(cookbook[13].name).to eq "Green Peas"
        expect(cookbook[13].avg_cooking_time).to eq "20"
        expect(cookbook[13].rating).to eq "1"
    end

    it "#Returns nil and prints an error message if no values or empty values" do
        new_cookbook = RecipeRepository.new
        expect(new_cookbook.find(nil, 0)).to eq nil
    end

    it "#Returns nil and prints an error message if no values or empty values" do
        new_cookbook = RecipeRepository.new
        expect(new_cookbook.find(13, 2)[0].name).to eq "Double Cheeseburger"
    end

    it "#Returns nil and prints an error message if no values or empty values" do
        new_cookbook = RecipeRepository.new
        expect(new_cookbook.find(18, 1)[0].name).to eq "Guacamole"
        expect(new_cookbook.find(18, 1)[1].name).to eq "Double Cheeseburger"
        expect(new_cookbook.find(18, 1)[2].name).to eq "Chicken Wings"
    end

end

end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.


--------------------------------------------------------------------------------------------------------------------------


To work on this challenge, first:

Setup a new project directory recipes_directory.
Create a new database recipes_directory.
Create a new test database recipes_directory_test for your tests.
Then:

Design and create the table for the following user stories.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep a list of all my recipes with their names.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep the average cooking time (in minutes) for each recipe.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to give a rating to each of the recipes (from 1 to 5).
Test-drive the Repository class for this new table. You should design, test-drive and implement two methods all and find.

Write code in the main file app.rb so it prints out the list of recipes.