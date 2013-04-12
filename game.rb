hero = {
  name: "Donald",
  level: 1,
  exp: 0,
  max_hp: 100,
  hp: 100,
  strength: 10,
  wisdom: 5,
  defense: 1,
  speed: 2,
  luck: 0
}

enemy = {
  name: "Gurlock",
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

def attack(attacker, victim)
  damage = attacker[:strength] + (rand(attacker[:strength]) - attacker[:strength]/2) / 10
  victim[:hp] -= damage
  puts "#{attacker[:name]} strikes #{victim[:name]} for #{damage} points! #{victim[:name]} HP:#{victim[:hp]}"
end

def run(player, enemy)
  if player[:speed] + player[:luck] > rand((enemy[:speed]+enemy[:luck]) * 2)
    return true
  else
    return false
  end
end

def displayItems(inventory)
  inventory.each { |item, quantity| puts "#{item} - stock:#{quantity}"}
end

def useItem(inventory)
  displayItems(inventory)
  puts "Type the item you wish to use:"
  choice = gets.chomp.to_sym
  inventory[choice] -= 1
end

def reviveEnemy(enemy)
  enemy[:hp] = enemy[:max_hp]
end

def calcExp(player, enemy)
  if ( enemy[:level] - player[:level] ) < 1
    bonus = enemy[:level] - player[:level]
  else
    bonus = 1
  end
  player[:exp] += enemy[:max_hp] * enemy[:strength] * bonus
end

def playerLvlUp(player)
  levels = {
    1 => 500,
    2 => 1000,
    3 => 2000,
    4 => 4000,
    5 => 7000,
    6 => 9000,
    7 => 14000,
    8 => 20000,
    9 => 30000,
  }
  if player[:exp] > levels[player[:level]]
    puts "LEVEL UP!"
    player[:level] += 1
    stats = [:max_hp,:strength,:wisdom,:defense,:speed,:luck]
    stats.each do |attribute|
      if player[attribute]/10 < 1
        player[attribute] += 1
      else
        player[attribute] += player[attribute]/10
      end
    end
    displayStats(player)
    player[:hp] = player[:max_hp]
  else
    puts "Next level in #{levels[player[:level]]- player[:exp]} points."
  end
end   

def levelUpEnemy(enemy)
  enemy[:level] += 1
  stats = [:max_hp,:strength,:wisdom,:defense,:speed,:luck]
  stats.each do |attribute|
    if enemy[attribute]/10 < 1
      enemy[attribute] += 1
    else
      enemy[attribute] += enemy[attribute]/10
    end
  end
end

def displayStats(enemy)
  enemy.each do |attribute, stat|
    puts "#{attribute.to_s.capitalize}: #{enemy[attribute]}"
  end
end    

def battle(player, enemy)
  if player[:speed] >= enemy[:speed]
    until enemy[:hp] <= 0 or player[:hp] <= 0
      attack(player, enemy)
      attack(enemy, player)
    end
  else
    until enemy[:hp] <= 0 or player[:hp] <= 0
      attack(enemy, player)
      attack(player, enemy)
    end
  end
  if enemy[:hp] <= 0
    puts "You won the battle!"
    levelUpEnemy(enemy)
    reviveEnemy(enemy)
    calcExp(player, enemy)
    playerLvlUp(player)
  else
    puts "You lost, hit the gym!"
  end  
end

def gauntlet(player, enemy)
  wins = 0
  until player[:hp] <= 0
    battle(player, enemy)
    displayStats(enemy)
    wins += 1
    puts "Hit enter to fight the next battle."
    gets.chomp
  end
  puts wins
end 

gauntlet(hero, enemy)
