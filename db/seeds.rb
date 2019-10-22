Planet.destroy_all

earth = Planet.create(
  name: "Earth", 
  distance_from_sun: 92531871, 
  atmosphere: "Breathable", 
  description: "Third planet from the Sun. Earth has one moon: Moon, and no rings. It is a rocky, terrestrial planet, that has a solid and active surface with mountains, valleys, canyons, plains and so much more. Earth is special because it is an ocean planet.",
  image: "earth.jpg")

jupiter = Planet.create(
  name: "Jupiter", 
  distance_from_sun: 488293103, 
  atmosphere: "Gassy",
  description: "Jupiter is the biggest planet in solar system.
  It is covered in swirling cloud stripes. It has big storms like the Great Red Spot, which has been going for hundreds of years. It has rings, but they're too faint to see very well.",
  image: "jupiter.jpg"
)

saturn = Planet.create(
  name: "Saturn", 
  distance_from_sun: 933368770, 
  atmosphere: "Hot",
  description: "Saturn is the sixth planet from the Sun. Saturn has the most beautiful rings. They’re made of chunks of ice and rock. Twice every 29 and a half years the great planet Saturn appears ringless.",
  image: "saturn.jpg"
)

uranus = Planet.create(
  name: "Uranus", 
  distance_from_sun: 1751007689, 
  atmosphere: "Gassy",
  description: "Uranus is the seventh planet from the Sun. It is made of water, methane, and ammonia fluids above a small rocky center. It has 13 faint rings.",
  image: "uranus.jpg")

neptune = Planet.create(
  name: "Neptune", 
  distance_from_sun: 2782537545, 
  atmosphere: "Gassy", 
  description: "Neptune is the eighth planet from the Sun. It is dark, cold, and very windy. It is made of a thick soup of water, ammonia, and methane. Neptune has six rings, but they're very hard to see.",
  image: "neptune.jpg"
)
 
mercury = Planet.create(
  name: "Mercury", 
  distance_from_sun: 38707465, 
  atmosphere: "Thin, hot, and windy.", 
  description: "Mercury is the smallest planet in the solar system, and is closest to the Sun. It is a rocky planet, with a solid, cratered surface.",
  image: "mercury.jpg"
  )
 
venus = Planet.create(
  name: "Venus", 
  distance_from_sun: 67470137, 
  atmosphere: "Thick, hot, and cloudy.", 
  description: "Venus is the second planet from the Sun, and the hottest. Venus is a very active planet, with mountains and volcanoes.",
  image: "venus.jpg"
  )

mars = Planet.create(
  name: "Mars", 
  distance_from_sun: 153352194, 
  atmosphere: "Thin, cold and rusty.", 
  description: "Mars is the fourth planet from the Sun. It is a cold desert world that nevertheless has seasons, polar ice caps, volcanoes, canyons, and weather. On some Martian hillsides, there is evidence of liquid salty water in the ground.",
  image: "mars.jpg")
