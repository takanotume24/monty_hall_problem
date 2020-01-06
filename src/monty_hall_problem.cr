def select_door(correct_door, first_selected_door, doors) : Array(Int32)
  doors.delete first_selected_door

  if correct_door == first_selected_door
    doors.delete_at Random.rand doors.size
  else
    deletable_doors = doors.clone
    deletable_doors.delete correct_door
    deletable_doors.delete first_selected_door
    doors.delete deletable_doors[Random.rand deletable_doors.size]
  end
  return doors
end

def choise_second_door(doors) : Int
  return doors[Random.rand doors.size]
end

loop : Int64 = ARGV[0].to_i64

atari = 0
atari_changed = 0

loop.times do |i|
  correct_door = Random.rand 3
  first_selected_door = Random.rand 3
  doors = Array.new(3) { |i| i }

  if correct_door == first_selected_door
    atari += 1
  end

  doors = select_door correct_door, first_selected_door, doors
  second_selected_door = choise_second_door doors

  if correct_door == second_selected_door
    atari_changed += 1
  end
end

puts "変えずに当たる確率 : \t#{atari / loop}"
puts "変えて当たる確率 : \t#{atari_changed / loop}"
