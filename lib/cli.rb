def welcome
    puts "Welcome to the Milky Way Travel Agency!"
    puts "Interstellar travel at your fingertips."
end

def planets_display
    puts "Here are all of the available destinations:"
    Planet.all.map do |planet|
        planet.name
        puts planet.name
    end
end

def select_planet
    puts "Please enter your preferred destination"
    user_input = gets.chomp
    selected_planet = display_selected_planet(user_input)
    puts selected_planet
end

def display_selected_planet(planet_name)
    planet = Planet.all.find do |planet|
        planet.name == planet_name
    end
        puts "
        Name: #{planet.name}
        Atmosphere: #{planet.atmosphere}
        Description: #{planet.description}"
        system("imgcat ./lib/images/#{planet.image}")
end