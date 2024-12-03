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

def line_valid(line)
  return false unless asc_or_desc(line)

  (0..line.length - 2).each do |i|
    diff = (line[i] - line[i + 1]).abs
    return false if diff > 3 || diff == 0
  end

  true
end

contents.each do |line|
  report = line.split.map(&:to_i)
  report_valid = false

  if line_valid(report)
    report_valid = true
  else
    # try removing each element to see if line becomes valid
    (0..report.length - 1).each do |i|
      report_copy = report.dup
      report_copy.delete_at(i)
      # debugger if report == [23, 25, 23, 20, 19, 20, 17, 11]
      report_valid = true if line_valid(report_copy)
    end
  end

  total += 1 if report_valid
end

puts total
