class RecipeRepository
    
    def primitive_all
        # ###### THIS was the first attempt before thinking about printing everything from the same function ######
        # sql = 'SELECT * FROM recipes;'
        # result = DatabaseConnection.exec_params(sql, [])
        # @cookbook = []
        # result.each do |recipe|
        #     recipe_sample = Recipe.new
        #     methods = [:id, :name, :avg_cooking_time, :rating]
        #     methods.each do |m| 
        #         recipe_sample.send("#{m}=", recipe[m.to_s]) # <<< Inception vibes
        #     end
        #     @cookbook << recipe_sample
        # end
        # return @cookbook
        universal_all(true, true, false) # print function can be called with all the values
    end

    def print_values(recipe_sample, time, rate)
        print_string = "Recipe ##{recipe_sample.id} " + " "*(3-recipe_sample.id.to_s.length) +
                "| #{recipe_sample.name} " + " "*(20-recipe_sample.name.length) + "|"
        if time #if we requested time, we also add the values
            print_string.concat(" Avg. cooking time: #{recipe_sample.avg_cooking_time}' | ")
        end
        if rate #if we requested rating, we also add this
            print_string.concat(" Rating: " + "*"*recipe_sample.rating.to_i + " "*(5-recipe_sample.rating.to_i) + " |")
        end
        puts print_string #now with all the information we need to know, we print the list
    end
    
    def add_option (search_values, option)
        @search_values = search_values + option # << creates the string which will customize the search
        @methods << option.delete_prefix(", ").to_sym # << add the options for the iteration and takes out the space and comma which would give us an error
    end

    def universal_all (time = false, rate = false, print = true, condition = "")
        if print then puts "****"*20 end # << just a visual aid // Commodore Amiga 64 Vibes
        @search_values = "" # Initialize an auxiliar variable which will help us later on the search
        @methods = [:id, :name] # Initialize a methods array with the two methods that will always be present at all searches
        #if name then add_option(@search_values, "name, ") end
        if time then add_option(@search_values, ", avg_cooking_time") end # Add avg cooking time if requested, for the method and db
        if rate then add_option(@search_values, ", rating") end # Add rating if requested, for the method and db
        #@search_values.chomp!(", ")
        #if condition != false then add_option(@search_values, condition) end
        sql = "SELECT id, name #{@search_values} FROM recipes #{condition};" #This make the db call with the parameters we want 
        result = DatabaseConnection.exec_params(sql, [])
        @cookbook = [] #We initialize our list or the list we want to produce
        result.each do |recipe| #For each object in the list/each recipe (address, and values from variables)
            recipe_sample = Recipe.new #We create a new object to contain the information and reserve the memory for that specific object
            #methods = [:id, :name, :avg_cooking_time, :rating]
            @methods.each do |m| #With the methods array we have completed before, we iterate for our search
                recipe_sample.send("#{m}=", recipe[m.to_s]) # <<< Inception vibes #this takes the method we are working on and assing the value 
                                                            #from the recipe we were working on -last iteration- 
            end
            @cookbook << recipe_sample #We add the object to our list to create our "cookbook"
            #And now here it comes Mr User Friendly and print things nice
            if print
                print_values(recipe_sample, time, rate)
            end

        end
        if print then puts "****"*20 end # << just a visual aid // Commodore Amiga 64 Vibes
        #@cookbook.each |
        return @cookbook # << we can return a list with all the objects/recipes requested by the user or we can work with it later
                        # I guess with an argument which indicates if the DB has been modified (insert/delete) we could save another
                        # iteration through all the DB if it's not too big or we were working with all if the DB
    end

    def find (timecondition = nil, ratecondition = 0)  #En verdad puedo usar el método de antes y además darle una condición
                                                        #querré algo que sea mayor que cierto rating y menor que cierto tiempo
                                                        # si el tiempo y el rate es verdadero añade AND si no, usa uno de los dos y listo
                                                        # ya tengo algo que busca time y rate quiero solo la condicion
        condition = " WHERE"
        if timecondition != nil
            condition = condition + " avg_cooking_time <= " + timecondition.to_s
            time = true
        end
        if (timecondition != nil && ratecondition != 0)
            condition = condition + " AND" #añade AND
        end
        if ratecondition > 0
            condition = condition + " rating >= " + ratecondition.to_s
            rate = true
        end
        if condition != " WHERE"
            universal_all(time, rate, true, condition)
        else
            puts "Search values not defined."
            return nil
        end

    end

end