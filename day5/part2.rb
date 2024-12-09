require 'debug'

# file_path = ARGV[0]


# Read the file
file = File.open('input_sample.txt', 'r')
contents = file.readlines.map(&:chomp)

empty_item = contents.index('')
rules = contents[0..empty_item - 1]
instructions = contents[empty_item + 1..-1]

page_rules = {}
rules.each do |rule|
  rule = rule.split('|')
  if page_rules[rule[0]]
    page_rules[rule[0]].append(rule[1])
  else
    page_rules[rule[0]] = [rule[1]]
  end
end

total = 0

instructions.each do |instruction|
  pages = instruction.split(',')
  valid = true
  seen = []
  # debugger
  pages.each do |page|
    if page_rules[page]
      bad_value = (seen & page_rules[page]).first
      # i think we need to just keep pushign the value until we no longer find anything bad
      if bad_value
        valid = false
        debugger
        pages.delete(bad_value)
        seen.delete(bad_value)
        pages.insert(pages.index(page) + 1, bad_value)
      end
    end
    seen.append(page)
  end

  if valid == false
    puts "correct pages #{pages}"
    middle_value = pages[pages.length / 2]
    total += middle_value.to_i
  end
end

puts total