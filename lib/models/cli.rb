ActiveRecord::Base.logger = nil

class Cli

    attr_accessor :user_info, :selected_planet, :distance_total, :total_in_years

    def initialize
        @user_info = nil
        @selected_planet = nil
        @distance_total = nil
        @total_in_years = nil
    end

    def welcome
        system("clear")
        puts "Welcome to the Milky Way Travel Agency!"
        puts "Interstellar travel at your fingertips."
        user_intro
        planets_display
        select_planet
        distance_from_selection
        display_travel_time
        display_arrival_age
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
        @selected_planet = Planet.find_by(name: user_input)
        if selected_planet
            display_selected_planet
        else  
            puts "We currently do not offer travel to that destination. Please select from the above list."
            select_planet
        end
    end

    def display_selected_planet
        # planet = Planet.where(name: planet_name).limit(1)[0]
            puts "
            Name: #{selected_planet.name}
            Atmosphere: #{selected_planet.atmosphere}
            Description: #{selected_planet.description}"
            system("imgcat ./lib/images/#{selected_planet.image}")
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
        @user_info = User.create(name: user_name, age: user_age, planet_location: user_location)
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

    def current_location
        user_info.planet_location
    end

    def current_distance
        planet = Planet.find_by(name: current_location)
        planet.distance_from_sun
    end

    def destination_name
        selected_planet.name
    end

    def destination_distance
        planet = Planet.find_by(name: destination_name)
        planet.distance_from_sun
    end

    def distance
        @distance_total = destination_distance + current_distance
        puts "Your total travel distance to #{destination_name} is #{distance_total} miles. Please be aware that this is not a direct flight, and there will be a layover at the Sun."
    end


    def distance_from_selection
        puts "Would you like to see the distance to your selection? Y/N"
        user_input = gets.chomp.downcase
        if user_input == "y" || user_input == "yes"
            distance
        else
            ending_options
        end
    end

    def travel_time
        total_in_hours = distance_total / 80000
        total_in_days = total_in_hours.to_f  / 24
        @total_in_years = total_in_days.to_f / 365
        puts "Your travel time would be #{total_in_days.round(1)} days or #{total_in_years.round(1)} years."
    end

    def display_travel_time
        puts "Would you like to see the travel time to your selected planet? Y/N"
        user_input = gets.chomp.downcase
        if user_input == "y" || user_input == "yes"
            travel_time
        else
            ending_options
        end
    end

    def user_age
        user_info.age
    end

    def display_arrival_age
        puts "Would you like to know how old you'll be when you arrive on #{destination_name}? Y/N"
        user_input = gets.chomp.downcase
        if user_input == "y" || user_input == "yes"
            if total_in_years.round == 0
                puts "You will be #{user_age} years old."
                ending_options
            else
                puts "You will be #{user_age * total_in_years.round} years old."
                ending_options
            end
        else 
            ending_options
        end
    end


    def user_id
        user_info.map do |user|
            user.id
            puts user.id
        end
    end
end