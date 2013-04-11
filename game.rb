hero_hp = 100
hero_strength = 10

enemy_hp = 100
enemy_strength = 10

def attack(strength)
  return strength + rand(strength/10 + 2) - strength/10
end

until enemy_hp <= 0 or hero_hp <= 0
  enemy_hp -= attack(hero_strength)
  puts enemy_hp
  hero_hp -= attack(enemy_strength)
  puts hero_hp
end

if enemy_hp <= 0
  puts "You won the battle!"
else
  puts "You lost, hit the gym!"
end
