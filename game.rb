hero_hp = 100
hero_strength = 10

enemy_hp = 100
enemy_strength = 10

def attack(strength)
  return strength + rand(strength/10 + 2) - strength/10
end

until enemy_hp == 0
  enemy_hp -= attack(hero_strength)
  puts enemy_hp
end
