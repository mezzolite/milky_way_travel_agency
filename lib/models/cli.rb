ActiveRecord::Base.logger = nil

class Cli

    attr_accessor :user_info, :selected_planet, :distance_total, :total_in_years, :favorite_planets, :delimited_total, :total_in_days

    def initialize
        @user_info = nil
        @selected_planet = nil
        @distance_total = nil
        @total_in_years = nil
        @favorite_planets = []
        @delimited_total = nil
        @total_in_days = nil
    end

    def welcome
        system("clear")
        puts "*---*---o---*---~---o---~---*---o---*---*"
        puts "--*---*---o---*---~---o---~---*---o---*--"
        puts "Welcome to the Milky Way Travel Agency!".colorize(:magenta)
        puts "Interstellar travel at your fingertips.".colorize(:light_red)
        system("imgcat ./lib/images/background.jpg")
        user_intro
        puts ""
        main_menu
    end

    def main_menu
        planets_display
        select_planet
        distance_from_selection
        puts ""
    end

    def user_intro
        puts ""
        puts "Please tell us about yourself.".colorize(:yellow)
        puts ""
        puts "What is your name?"
        user_name = gets.chomp
        puts ""
        puts "How old are you?"
        user_age = gets.chomp.to_i
        puts ""
        user_location = user_planet
        @user_info = User.create(name: user_name, age: user_age, planet_location: user_location)
    end

    def user_planet
        puts "What planet in the Solar System do you currently reside on?"
        user_location = gets.chomp.capitalize
        solar_planets = Planet.find_by(name: user_location)
        if solar_planets
            puts ""
            user_location
        else 
            puts ""
            puts "Please enter a planet in the Solar System.".colorize(:red)
            user_planet
        end
    end


    def planets_display
        system("clear")
        Planet.all.map do |planet|
            planet.name 
            puts planet.name
            system("imgcat ./lib/images/#{planet.image}")
        end
        puts "*---*---o---*---~---o---~---*---o---*---*"
        puts "--*---*---o---*---~---o---~---*---o---*--"
        puts "Here are all of the available destinations!".colorize(:green)
        puts ""
    end

    def select_planet
        puts "Please enter your preferred destination"
        user_input = gets.chomp.capitalize
        system("clear")
        @selected_planet = Planet.find_by(name: user_input)
        if selected_planet
            display_selected_planet
        else  
            puts "We currently do not offer travel to that destination. Please select from the above list.".colorize(:red)
            select_planet
        end
    end

    def display_selected_planet
            puts "Here is the information about your selection!".colorize(:blue)
            puts ""
            puts "Name: ".colorize(:light_blue) + "#{selected_planet.name}"
            puts "Atmosphere: ".colorize(:light_blue) + "#{selected_planet.atmosphere}"
            puts "Description: ".colorize(:light_blue) + "#{selected_planet.description}"
            system("imgcat ./lib/images/#{selected_planet.image}")
            puts "*---*---o---*---~---o---~---*---o---*---*"
            puts "--*---*---o---*---~---o---~---*---o---*--"
    end

    def ending_options
        puts ""
        puts "*---*---o---*---~---o---~---*---o---*---*"
        puts "--*---*---o---*---~---o---~---*---o---*--"
        puts "What would you like to do now? Please select 1, 2, or 3.".colorize(:yellow)
        puts "1. Go back to Planet Menu."
        puts "2. View your Favorite Planets."
        puts "3. Exit Travel Agency."
        user_input = gets.chomp
        if user_input == "1"
            system("clear")
            main_menu
        elsif user_input == "3"
            puts ""
            puts ""
            puts "Thank you for visiting the Milky Way Travel Agency. Good Bye!".colorize(:magenta)
            system("imgcat ./lib/images/purple_solarsystem.jpg")
        elsif user_input == "2"
            display_favorites
        else
            puts "Please make another selection."
        ending_options
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
        @delimited_total = distance_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def print_distance
        puts "Your total travel distance to " + "#{destination_name}".colorize(:light_green) + " is " + "#{delimited_total}".colorize(:green) + " miles. Please be aware that this is not a direct flight, and there will be a layover at the Sun."
    end


    def distance_from_selection
        puts ""
        puts "Would you like to see the distance to your selection? Y/N"
        user_input = gets.chomp.downcase
        if user_input == "y" || user_input == "yes"
            distance
            print_distance
            puts ""
            display_travel_time
        elsif user_input == "n" || user_input == "no"
            display_travel_time
        else
            puts "Please enter Y or N."
            distance_from_selection
        end
    end

    def travel_time
        total_in_hours = distance_total / 80000
        @total_in_days = total_in_hours.to_f  / 24
        @total_in_years = total_in_days.to_f / 365
    end

    def print_travel_time
        puts "Your travel time would be " + "#{total_in_days.round(1)}".colorize(:green) + " days or " + "#{total_in_years.round(1)}".colorize(:green) + " years."
    end

    def display_travel_time
        puts "Would you like to see the travel time to your selected planet? Y/N"
        user_input = gets.chomp.downcase
        if user_input == "y" || user_input == "yes"
            distance
            travel_time
            print_travel_time
            puts ""
            display_arrival_age
        elsif user_input == "n" || user_input == "no"
            display_arrival_age
        else
            puts "Please enter Y or N."
            display_travel_time
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
                puts "You will be " + "#{user_age}".colorize(:green) + " years old."
                puts ""
                favorites
            else
                distance
                travel_time
                puts "You will be " + "#{user_age + total_in_years.round}".colorize(:green) + " years old."
                puts ""
                favorites
            end
        elsif user_input == "n" || user_input == "no"
            favorites
        else 
            puts "Please enter Y or N."
            display_arrival_age
        end
    end

    def get_user_id
        user_info.id 
    end

    def selected_planet_id
        selected_planet.id
    end

    def favorites
        puts "Would you like to save this planet to your Favorites? Y/N"
        user_input = gets.chomp.downcase
        if user_input == "y" || user_input == "yes"
            @favorite_planets << Favorite.create(user_id: get_user_id, planet_id: selected_planet_id)
            ending_options
        else
            ending_options    
        end
    end

    def display_favorites
        system("clear")
        user_info.planets.reload.map do|planet|
            puts "Name: ".colorize(:light_blue) + "#{planet.name}"
            puts "Atmosphere: ".colorize(:light_blue) + "#{planet.atmosphere}"
            puts "Description: ".colorize(:light_blue) + "#{planet.description}"
            system("imgcat ./lib/images/#{planet.image}")
        end
        ending_options
    end 

    
end

