require 'debug'

# Read the file
file = File.open('input.txt', 'r')
@map = file.readlines.map(&:chomp).map(&:chars)


@dir_coords = {
  'up' => [-1, 0],
  'down' => [1, 0],
  'left' => [0, -1],
  'right' => [0, 1]
}
@dir_change = {
  'up' => 'right',
  'right' => 'down',
  'down' => 'left',
  'left' => 'up'
}

def find_guard
  possible_guard = %w[< > ^ v]

  @map.each_with_index do |row, rindex|
    cindex = possible_guard.map{|guard| @map[rindex].index(guard)}.compact
    return [rindex, cindex.first] if cindex.any?
  end
end

def coords_out_of_bounds(coords)
  return true if coords[0] < 0 || coords[0] > @map.length - 1
  return true if coords[1] < 0 || coords[1] > @map[0].length - 1
  false
end

def next_move(guard_coords, dir)
  change_coords = @dir_coords[dir]
  next_coords = [guard_coords[0] + change_coords[0], guard_coords[1] + change_coords[1]]
  return 'off_map' if coords_out_of_bounds(next_coords)
  debugger if @map[next_coords[0]].nil?
  return 'change_dir' if @map[next_coords[0]][next_coords[1]] == '#'
  next_coords
end


guard_coords = find_guard
guard = @map[guard_coords[0]][guard_coords[1]]

direction = ''
case guard
when '^'
  direction = 'up'
when '>'
  direction = 'right'
when 'v'
  direction = 'down'
else
  direction = 'left'
end

total = 1
moves_remaining = true

while moves_remaining
  next_m = next_move(guard_coords, direction)
  case next_m
  when 'off_map'
    moves_remaining = false
  when 'change_dir'
    direction = @dir_change[direction]
    puts "changing direction to #{direction}"
  else
    guard_coords = next_m
    total += 1
    puts "guard coords: #{guard_coords}"
    puts "total is #{total}"
  end
end

puts @total