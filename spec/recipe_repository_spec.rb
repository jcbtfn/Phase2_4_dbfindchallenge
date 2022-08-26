#require 'database_connection'
require 'recipe'
require 'recipe_repository'

def reset_recipe_table
    seed_sql = File.read('spec/recipe_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
end

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

# it "#Returns the information of book 2 - Mrs Dalloway Virginia Woolf" do
#     library = BookRepository.new
#     expect(library.all[1].id).to eq "2"
#     expect(library.all[1].title).to eq "Mrs Dalloway"
#     expect(library.all[1].author_name).to eq "Virginia Woolf"
# end

# it "#Returns an array of all the title [Nineteen Eighty-Four, Mrs Dalloway, Emma, Dracula, The Age of Innocence]" do
#     library = BookRepository.new
#     expect(library.print_title).to eq ["Nineteen Eighty-Four", "Mrs Dalloway", "Emma", "Dracula", "The Age of Innocence"]
# end
    # (your tests will go here).
