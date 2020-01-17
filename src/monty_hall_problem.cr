def openable_doors(correct_door, first_selected_door, doors) : Hash(Int32, Bool)
  doors.delete first_selected_door
  hazure_doors = doors.select { |key, value| value == false }
  delete_door = hazure_doors.keys[Random.rand hazure_doors.keys.size]
  doors.delete delete_door
  return doors
end

def choise_second_door(doors : Hash(Int32, Bool)) : Int
  return doors.keys[Random.rand doors.keys.size]
end

door_num = ARGV[0].to_i
loop : Int64 = ARGV[1].to_i64

atari = 0
atari_changed = 0

doors = Hash(Int32, Bool).new

loop.times do |i|
  correct_door = Random.rand door_num
  first_selected_door = Random.rand door_num

  door_num.times do |i|
    doors[i] = false
  end

  doors[correct_door] = true

  if doors[first_selected_door]
    atari += 1
  end

  doors = openable_doors correct_door, first_selected_door, doors
  second_selected_door = choise_second_door doors

  if doors[second_selected_door]
    atari_changed += 1
  end
end

puts "変えずに当たる確率 : \t#{atari / loop}"
puts "変えて当たる確率 : \t#{atari_changed / loop}"
