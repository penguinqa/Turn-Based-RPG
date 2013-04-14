require './functions.rb'

hero = {
  name: "Quint",
  level: 1,
  exp: 0,
  max_hp: 100,
  hp: 100,
  max_mp: 24,
  mp: 24,
  strength: 12,
  wisdom: 5,
  base_defense: 5,
  defense: 5,
  speed: 2,
  luck: 0,
  gender: "her"
}

enemy = {
  name: "Rosie",
  level: 1,
  max_hp: 40,
  hp: 40,
  strength: 13,
  wisdom: 5,
  defense: 4,
  speed: 2,
  luck: 0
}

inventory = {
  potion: 3,
  hi_potion: 1,
  x_potion: 1
}

gauntlet(hero, enemy, inventory)
