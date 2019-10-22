def welcome
    puts "Welcome to the Milky Way Travel Agency!"
    puts "Interstellar travel at your fingertips."
end

def planets_display
    Planet.all.map do |planet|
        planet.name
        puts planet.name
    end
end