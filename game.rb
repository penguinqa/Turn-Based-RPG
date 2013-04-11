hero = {
  hp: 100,
  strength: 10,
  wisdom: 5,
  defense: 1,
  speed: 2,
  luck: 0
}

enemy = {
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

until enemy[:hp] <= 0 or hero[:hp] <= 0
  enemy[:hp] -= attack(hero[:strength])
  puts enemy[:hp]
  hero[:hp] -= attack(enemy[:strength])
  puts hero[:hp]
end

if enemy[:hp] <= 0
  puts "You won the battle!"
else
  puts "You lost, hit the gym!"
end
