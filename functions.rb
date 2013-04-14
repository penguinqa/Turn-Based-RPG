###########################
#    BATTLE INITIATION    #
###########################
def battle(player, enemy, inventory)
  if player[:speed] >= enemy[:speed]
    until enemy[:hp] <= 0 or player[:hp] <= 0
      battleDisplay(player, enemy)
      actions(player, enemy, inventory)
      unless enemy[:hp] <= 0 or player[:hp] <= 0
        attack(enemy, player)
      end
      unDefend(player)
    end
  else
    until enemy[:hp] <= 0 or player[:hp] <= 0
      battleDisplay(player, enemy)
      attack(enemy, player)
      unless enemy[:hp] <= 0 or player[:hp] <= 0
        actions(player, enemy, inventory)
      end
      unDefend(player)
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

def gauntlet(player, enemy, inventory)  #Repeats Battle Until Player HP == 0
  wins = 0                              #Good For Testing
  until player[:hp] <= 0
    battle(player, enemy, inventory)
    displayStats(enemy)
    wins += 1
    puts "Hit enter to fight the next battle."
    gets.chomp
  end
  puts wins
end

###########################
#    BATTLE COMMANDS      #
###########################

def actions(player, enemy, inventory)
  puts "Enter 1 to Attack"
  puts "Enter 2 to Use Magic"
  puts "Enter 3 to Defend"
  puts "Enter 4 to Use Items"
  puts "Enter 5 to Run"
  print ">:"
  action = gets.chomp

  case action
  when "1"
    attack(player, enemy)
  when "2"
    magic(player, enemy)
  when "3"
    defend(player)
  when "4"
    useItem(inventory)
  when "5"
    run(player, enemy)
  else
    puts "Not an acceptable entry"
    actions(player, enemy, inventory)
  end
end

def attack(player, enemy)
  damage = player[:strength] + (rand(player[:strength]) - player[:strength]/2) / 10 - enemy[:defense]
  enemy[:hp] -= damage
  puts "#{player[:name]} strikes #{enemy[:name]} for #{damage} points! #{enemy[:name]} HP:#{enemy[:hp]}"
end

def magic(player, enemy, inventory)
  puts "Enter 1 to use Fire. MP cost: 4"
  puts "Enter 2 to use Ice. MP cost: 4"
  puts "Enter 3 to use Thunder. MP cost: 4"
  puts "Enter 4 to use Cure. MP cost: 4"
  print ">:"
  spell = gets.chomp
  damage = 4 * player[:wisdom]
  if player[:mp] < 4
    puts "Not enough MP"
    actions(player, enemy, inventory)
  else
    case spell
    when "1"
      player[:mp] -= 4
      enemy[:hp] -= damage
      puts "#{player[:name]} torches #{enemy[:name]} for #{damage} points! #{enemy[:name]} HP:#{enemy[:hp]}"
    when "2"
      player[:mp] -= 4
      enemy[:hp] -= damage
      puts "#{player[:name]} freezes #{enemy[:name]} for #{damage} points! #{enemy[:name]} HP:#{enemy[:hp]}"
    when "3"
      player[:mp] -= 4
      enemy[:hp] -= damage
      puts "#{player[:name]} electrocutes #{enemy[:name]} for #{damage} points! #{enemy[:name]} HP:#{enemy[:hp]}"
    when "4"
      player[:mp] -= 4
      if ( player[:hp] + (player[:max_hp] * 0.33).to_i + player[:wisdom] ) > player[:max_hp]
        player[:hp] = player[:max_hp]
      else
        player[:hp] += (player[:max_hp] * 0.33).to_i + player[:wisdom]
      end
      puts "#{player[:name]} cast Cure. HP: #{player[:hp]}/#{player[:max_hp]}"
    else
      player[:hp] -= 5
      puts "#{player[:name]} got tongue tied and the spell back-fired on player[:gender]! #{player[:name]} HP: #{player[:hp]}"
    end
  end
end

def defend(player)
  player[:defense] += (player[:base_defense] * 0.5).to_i
end

def displayItems(inventory)
  inventory.each { |item, quantity| puts "#{item} - stock:#{quantity}"}
end

def useItem(inventory)
  displayItems(inventory)
  puts "Type the item you wish to use:"
  choice = gets.chomp.to_sym
  unless inventory[choice] == nil
    inventory[choice] -= 1
  end
end

def run(player, enemy)
  if player[:speed] + player[:luck] > rand((enemy[:speed]+enemy[:luck]) * 2)
    return true
  else
    return false
  end
end

###########################
#    STAT MANIPULATION    #
###########################
def battleDisplay(player, enemy)
  puts "#{player[:name]} | HP: #{player[:hp]}/#{player[:max_hp]} | MP: #{player[:mp]}/#{player[:max_mp]}"
  puts "#{enemy[:name]} | HP: #{enemy[:hp]}/#{enemy[:max_hp]}"
end

def unDefend(player)
  player[:defense] = player[:base_defense]
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
    1 => 100,
    2 => 100,
    3 => 200,
    4 => 300,
    5 => 500,
    6 => 800,
    7 => 1300,
    8 => 2100,
    9 => 3400,
  }
  if player[:exp] > levels[player[:level]]
    puts "LEVEL UP!"
    player[:level] += 1
    stats = [:max_hp,:strength,:wisdom,:base_defense,:speed,:luck]
    stats.each do |attribute|
      if player[attribute]/10 < 1
        player[attribute] += 1
      else
        player[attribute] += player[attribute]/10
      end
    end
    displayStats(player)
    player[:hp] = player[:max_hp]
    unDefend(player)
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

#Use after battle to respawn enemy
def reviveEnemy(enemy)
  enemy[:hp] = enemy[:max_hp]
end

def displayStats(enemy)
  enemy.each do |attribute, stat|
    puts "#{attribute.to_s.capitalize}: #{enemy[attribute]}"
  end
end
