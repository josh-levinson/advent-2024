# frozen_string_literal: true

require 'debug'

# file_path = ARGV[0]


# Read the file
file = File.open('input.txt', 'r')
contents = file.readlines
total = 0

# split into separate arrays

def asc_or_desc(line)
  sorted = line.sort
  return true if line == sorted

  sorted = sorted.reverse
  return true if line == sorted

  false
end

contents.each do |line|
  report = line.split.map(&:to_i)
  next unless asc_or_desc(report)

  report_valid = true
  (0..report.length - 2).each do |i|
    diff = (report[i] - report[i + 1]).abs
    report_valid = false if diff > 3 || diff == 0
  end
  # debugger if report_valid == true

  total += 1 if report_valid
end

puts total
