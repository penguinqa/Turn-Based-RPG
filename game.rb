hero = {
  name: "Donald",
  hp: 100,
  strength: 10,
  wisdom: 5,
  defense: 1,
  speed: 2,
  luck: 0
}

enemy = {
  name: "Gurlock",
  hp: 100,
  strength: 10,
  wisdom: 5,
  defense: 1,
  speed: 2,
  luck: 0
}

def attack(strength)
  return strength + (rand(strength) - strength/2) / 10
end

def run(player, enemy)
  if player[:speed] + player[:luck] > rand((enemy[:speed]+enemy[:luck]) * 2)
    return true
  else
    return false
  end
end

def battle(player, enemy)
  if player[:speed] >= enemy[:speed]
    until enemy[:hp] <= 0 or player[:hp] <= 0
      enemy[:hp] -= attack(player[:strength])
      puts "#{player[:name]} strikes #{enemy[:name]}! #{enemy[:name]} HP:#{enemy[:hp]}"
      player[:hp] -= attack(enemy[:strength])
      puts "#{enemy[:name]} strikes #{player[:name]}! #{player[:name]} HP:#{player[:hp]}"
    end
  else
    until enemy[:hp] <= 0 or player[:hp] <= 0
      player[:hp] -= attack(enemy[:strength])
      puts "#{enemy[:name]} strikes #{player[:name]}! #{player[:name]} HP:#{player[:hp]}"
      enemy[:hp] -= attack(player[:strength])
      puts "#{player[:name]} strikes #{enemy[:name]}! #{enemy[:name]} HP:#{enemy[:hp]}"
    end
  end
  if enemy[:hp] <= 0
    puts "You won the battle!"
  else
    puts "You lost, hit the gym!"
  end  
end

battle(hero, enemy)
