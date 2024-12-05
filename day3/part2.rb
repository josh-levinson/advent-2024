# frozen_string_literal: true

require 'debug'

# Read the file
file = File.open('input.txt', 'r')
contents = file.read

regex = /mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))/
# 1. no do/don't before mul, accept
# 2. do before, don't after, accept
# 3. don't before, do after, reject
# 4. don't before, nothing after, reject

total = 0
active = true

contents.scan(regex) do |match|
  # match[3] is do()
  active = true if match[2]

  active = false if match[3]

  total += match[0].to_i * match[1].to_i if active && match[0]
end

puts total
