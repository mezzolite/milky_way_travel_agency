def welcome
    puts "Welcome to the Milky Way Travel Agency!"
    puts "Interstellar travel at your fingertips."
end

def planets_display
    puts "Here are all of the available destinations:"
    Planet.all.map do |planet|
        planet.name 
        puts planet.name
        system("imgcat ./lib/images/#{planet.image}")
    end
end

def select_planet
    puts "Please enter your preferred destination"
    user_input = gets.chomp.capitalize
    selected_planet = Planet.find_by(name: user_input)
    if selected_planet
        display_selected_planet(user_input)
    else  
        puts "We currently do not offer travel to that destination. Please select from the above list."
            select_planet
    end
end

def display_selected_planet(planet_name)
    planet = Planet.where(name: planet_name).limit(1)[0]
        puts "
        Name: #{planet.name}
        Atmosphere: #{planet.atmosphere}
        Description: #{planet.description}"
        system("imgcat ./lib/images/#{planet.image}")
end

def ending_options
    puts "What would you like to do now? Please select 1 or 2."
    puts "1. Go back to Planet Menu."
    puts "2. Exit Travel Agency."

    user_input = gets.chomp
    if user_input == "1"
        planets_display
        select_planet
        ending_options
    elsif user_input == "2"
        puts "Thank you for visiting Milky Way Travel Agency. Good Bye!"
    else
        puts "Please make another selection."
    ending_options
    end
end