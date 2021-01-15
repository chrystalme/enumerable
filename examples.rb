require './enumerable'
# my_arr = []
friends = %w[Sharon Leo Leila Brian Arun]
num = [1, 2, 3, 4, 5, 6, 7, 8]

puts "\n++++++  Test #1 my_each   ++++++"
friends.my_each { |friend| puts "#{friend} is my friend" }

puts "\n++++++  Test #2 my_each_with_index    ++++++"
friends.my_each_with_index { |friend, index| puts friend.to_s if index.odd? }

puts "\n++++++  Test #3 my_select   ++++++"
num.my_select { |x| puts x if x.even? }

puts "\n++++++  Test #4 my_all   ++++++"
p num.my_all?(&:odd?)
puts(%w[ant bear cat].my_all? { |word| word.length >= 3 })

puts "\n++++++  Test #5 my_any   ++++++"
p num.my_any?(&:even?)

puts "\n++++++  Test #6 my_none   ++++++"
friends.my_none? { |friend| friend.start_with?('Z') }

puts "\n++++++  Test #7 my_count    ++++++"
p num.my_count
p "She has #{friends.my_count} Friends"

puts "\n++++++  Test #8 my_map    ++++++"
p friends.my_map(&:upcase)
num.my_map { |i| puts i * 2 }

puts "\n++++++  Test #9 my_inject    ++++++"
pp num.my_inject(:+)

puts "\n++++++  Test #10 my_map_proc    ++++++"
p friends.my_map_proc(&:downcase)
num.my_map_proc { |i| puts i + 1200 }

puts "\n++++++  Test #11 multiply_els    ++++++"
puts multiply_els([2, 4, 5])
