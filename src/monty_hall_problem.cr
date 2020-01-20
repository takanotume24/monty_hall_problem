require "math"

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
m : Int64 = ARGV[1].to_i64
loop : Int64 = ARGV[2].to_i64

Dir.new("result")
file = File.open("result/data_m_#{m}_loop_#{loop}.csv", mode = "w")

atari = 0
atari_changed = 0

doors = Hash(Int32, Bool).new
datas = Hash(Float64, Int64).new

m.times do |i|
  datas[(i / m).significant(Math.log10 m + 1)] = 0
end

loop.times do |j|
  atari_changed = 0
  atari = 0

  m.times do |i|
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
  datas[(atari / m).significant(Math.log10 m + 1)] += 1
  # file << "#{j},#{atari / m},#{atari_changed / m}\n"
end

datas.each do |k, v|
  file << "#{k},#{v}\n"
end

puts "変えずに当たる確率 : \t#{atari / loop}"
puts "変えて当たる確率 : \t#{atari_changed / loop}"

file.close
