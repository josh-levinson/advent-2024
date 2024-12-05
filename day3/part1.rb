# frozen_string_literal: true

require 'debug'

# Read the file
file = File.open('input.txt', 'r')
contents = file.read

regex = /mul\((\d+),(\d+)\)/

total = 0

contents.scan(regex) do |match|
  puts match
  total += match[0].to_i * match[1].to_i
end

puts total
