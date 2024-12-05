# frozen_string_literal: true

require 'debug'

# Read the file
file = File.open('input.txt', 'r')
contents = file.readlines
@xmas_grid = contents.map(&:chomp).map(&:chars)

total = 0

@height = contents.length
@width = contents[0].length

def check_char(x, y)
  matches = 0
  # y is backwards because it starts in first row 0, and goes down to last row
  # check up
  matches += 1 if check_with_direction(x, y, 0, -1)
  # check down
  matches += 1 if check_with_direction(x, y, 0, 1)
  # check forward
  matches += 1 if check_with_direction(x, y, 1, 0)
  # check back
  matches += 1 if check_with_direction(x, y, -1, 0)
  # check diagonal up/forward
  matches += 1 if check_with_direction(x, y, 1, -1)
  # check diagonal down/forward
  matches += 1 if check_with_direction(x, y, 1, 1)
  # check diagonal up/back
  matches += 1 if check_with_direction(x, y, -1, -1)
  # check diagonal down/back
  matches += 1 if check_with_direction(x, y, -1, 1)

  matches
end

def check_with_direction(start_x, start_y, x, y)
  max_x = start_x + (3 * x)
  return false if max_x < 0 || max_x >= @width

  max_y = start_y + (3 * y)
  return false if max_y < 0 || max_y >= @height

  return false unless @xmas_grid[start_y + y][start_x + x] == 'M'
  return false unless @xmas_grid[start_y + (2 * y)][start_x + (2 * x)] == 'A'
  return false unless @xmas_grid[start_y + (3 * y)][start_x + (3 * x)] == 'S'

  true

rescue
  debugger
end

@xmas_grid.each_with_index do |row, y|
  row.each_with_index do |char, x|
    total += check_char(x, y) if char == 'X'
  end
end

puts total
