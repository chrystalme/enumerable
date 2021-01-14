# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  # 1 my_each
  def my_each
    to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
  end

  # 2 my_each_with_index
  def my_each_with_index
    to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
  end

  # 3 my_select
  def my_select
    to_enum(:my_select) unless block_given?

    my_arr = []
    to_a.my_each { |item| my_arr << item if yield item }
    my_arr
  end

  # 4 my_all
  def my_all?(param = nil)
    if block_given?
      to_a.my_each { |i| return false if yield(i) == false }
      return true
    elsif param.nil?
      to_a.my_each { |i| return false if i.nil? || i == false }
    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |i| return false unless [i.class, i.class.superclass].include?(param) }
    elsif !param.nil? and param.instance_of?(Regexp)
      to_a.my_each { |i| return false unless param.match(i) }
    else
      to_a.my_each { |i| return false if i != param }
    end
    true
  end

  # 5 my_any
  def my_any?(param = nil)
    if block_given?
      to_a.my_each { |i| return true if yield(i) }
      return false
    elsif param? nil
      to_a.my_each { |i| return true if i }
    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |i| return true if [i.class, i.class.superclass].include?(param) }
    elsif !param.nil? && param.instance_of?(Regexp)
      to_a.my_each { |i| return true if param.match(i) }
    else
      to_a.my_each { |i| return true if i == param }
    end
    false
  end

  # 6 my_none
  def my_none?(param = nil)
    if block_given?
      !my_any?(&Proc.new)
    else
      !my_any?(param)
    end
  end

  # 7 my_count
  def my_count(param = nil)
    count = 0
    if block_given?
      to_a.my_each { |i| count += 1 if yield(i) }
    elsif !block_given? && param.nil?
      count = to_a.length
    else
      count = to_a.my_select { |i| i == param }.length
    end
    count
  end

  # 8 my_map
  def my_map(proc = nil)
    to_enum(:my_map) unless block_given? || !proc.nil?

    my_arr = []
    if proc.nil?
      to_a.my_each { |i| my_arr << yield(i) }
    else
      to_a.my_each { |i| my_arr << proc.call(i) }
    end
    my_arr
  end

  # 9 my_inject
  def my_inject(initial = nil, symb = nil)
    if (!initial.nil? && symb.nil?) && (initial.is_a?(Symbol) || initial.is_a?(String))
      symb = initial
      initial = nil
    end
    if !block_given? && !symb.nil?
      to_a.my_each { |i| initial = initial.nil? ? i : initial.send(symb, i) }
    else
      to_a.my_each { |i| initial = initial.nil? ? i : yield(initial, i) }
    end
    initial
  end
end

# 10 multiply_els
def multiply_els(arr)
  arr.my_inject(1, '*')
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

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
friends.my_none? { |friend| friend.start_with?('S') }

puts "\n++++++  Test #7 my_count    ++++++"
p num.my_count
p "She has #{friends.my_count} Friends"

puts "\n++++++  Test #8 my_map    ++++++"
p friends.my_map(&:upcase)
num.my_map { |i| puts i * 2 }

puts "\n++++++  Test #9 my_inject    ++++++"
pp num.my_inject(:+)

puts "\n++++++  Test #10 multiply_els    ++++++"
puts multiply_els([2, 4, 5])
