# frozen_string_literal: true

require 'debug'

# file_path = ARGV[0]


# Read the file
file = File.open('input.txt', 'r')
contents = file.readlines

# split into separate arrays
arr1 = []
arr2 = []
total = 0

contents.each do |line|
  first = line.split[0].to_i
  second = line.split[1].to_i
  # debugger if first.nil? || second.nil?
  arr1 << first
  arr2 << second
end


arr1.each do |num|
  total += num * arr2.count(num)
end

puts total
