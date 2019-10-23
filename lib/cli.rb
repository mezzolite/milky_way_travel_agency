ActiveRecord::Base.logger = nil


def welcome
    system("clear")
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
    system("clear")
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
        system("clear")
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

def user_intro
    puts "Please tell us about yourself."
    puts "What is your name?"
    user_name = gets.chomp
    puts "How old are you?"
    user_age = gets.chomp.to_i
    user_location = user_planet
    User.create(name: user_name, age: user_age, planet_location: user_location)
end

def user_planet
    puts "What planet in the Solar System do you currently reside on?"
    user_location = gets.chomp.capitalize
    solar_planets = Planet.find_by(name: user_location)
    if solar_planets
        puts "Thank you!"
        user_location
    else 
        puts "Please enter a planet in the Solar System."
        user_planet
    end
end
