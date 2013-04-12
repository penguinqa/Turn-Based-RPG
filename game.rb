require './functions.rb'

hero = {
  name: "Quinn",
  level: 1,
  exp: 0,
  max_hp: 100,
  hp: 100,
  strength: 10,
  wisdom: 5,
  defense: 1,
  speed: 2,
  luck: 0,
  gender: "her"
}

enemy = {
  name: "Josie",
  level: 1,
  max_hp: 30,
  hp: 30,
  strength: 6,
  wisdom: 5,
  defense: 1,
  speed: 2,
  luck: 0
}

inventory = {
    potion: 3,
    hi_potion: 1,
    x_potion: 1    
  }

gauntlet(hero, enemy, inventory)
