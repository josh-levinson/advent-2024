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
  # if we're at the edge of the grid
  return false if x < 1 || x >= @width - 1|| y < 1 || y >= @height - 1

  top_left = @xmas_grid[y - 1][x - 1]
  top_right = @xmas_grid[y - 1][x + 1]
  bottom_left = @xmas_grid[y + 1][x - 1]
  bottom_right = @xmas_grid[y + 1][x + 1]

  values = [top_left, top_right, bottom_left, bottom_right]
  return true if values.count('M') == 2 && values.count('S') == 2 && top_left != bottom_right

  false
rescue
  debugger
end

@xmas_grid.each_with_index do |row, y|
  row.each_with_index do |char, x|
    total += 1 if char == 'A' && check_char(x, y)
  end
end

puts total
