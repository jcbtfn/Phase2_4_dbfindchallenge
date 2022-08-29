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

    def print_values(recipe_sample, time, rate) #this function is set just to print values
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

    def find (timecondition = nil, ratecondition = 0)  #Now can can use the method implemented before, thinking that when we want something
                                                        #related with rating, it will be equal or greater than, and when we want something
                                                        #related with time, should be equal or less than
                                                        #if both options are required then we add an AND if not uses the one that needs and it fine
                                                        #we are already showing/searching for time/rating, we just need a condition
        condition = " WHERE" #variable is initialized with the where statement
        if timecondition != nil #so if something comes, then we add it
            condition = condition + " avg_cooking_time <= " + timecondition.to_s #we add it to the previous string
            time = true #and we also initialize/give a value for calling the next function as we are going to make use of it
        end
        if (timecondition != nil && ratecondition != 0) #if both parameters are required, we need to add an AND for the db
            condition = condition + " AND" #we add the add to ourstring
        end
        if ratecondition > 0 #and now we continue adding -or not- the rating
            condition = condition + " rating >= " + ratecondition.to_s #then we add it to our string as well
            rate = true #and initialize/create the parameter for our next call to the method we created before
        end
        if condition != " WHERE" #If we did change our statement from the beginning then we proceed to pass it
            universal_all(time, rate, true, condition) #and we call our "universal" function to do the rest
        else #then is nothing has changed we don't do anything and show an error message 
            puts "Search values not defined."
            return nil #and we return nil to indicate nothing has been done as we don't have proper values
        end

    end

end