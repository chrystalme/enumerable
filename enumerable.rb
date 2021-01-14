module Enumerable
  # 1 my_each
  def my_each
    to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    #  self
  end

  # 2 my_each_with_index
  def my_each_with_index
    to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
     # self
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
    elsif !param.nil? and param.class == Regexp
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
    elsif !param.nil? && param.class == Regexp
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
    elsif !block_give? && param.nil?
      count = to_a.length
    else
      count = to_a.my_select { |i| i == param }.length
    end
    count
  end

  # 8 my_map
  def my_map(proc = nil)
    return to_enum(:my_map)
    unless block_given? || !proc.nil?

    my_arr = []
    if proc.nil?
      to_a.my_each { |i| my_arr << yield(i)}
    else
      to_a.my_each { |i| my_arr << proc.call(i) }                
    end
    my_arr 
  end

  #9 my_inject
  def my_inject(initial = nil, sy = nil)
    if ( !initial.nil? && sy.nil?) && (initial.is_a?(Symbol) || initial.is_a?(String))
      sy = initial
      initial = nil
    end
    if !block_given? && !sy.nil? 
      to_a.my_each {|i| initial = initial.nil?? i : initial.send(sy, i)}
    begin
      to_a.my_each { |i| 
        initial = initial.nil?
      ? i : yield
      (initial, i)
      }
    end
    initial
  end 
end


# my_arr = []
friends = %w[Sharon Leo Leila Brian Arun]
num = [1, 2, 3, 4, 5, 6, 7, 8]

puts "\n++++++  Test #1 my_each   ++++++"
friends.my_each { |friend| puts "#{friend} is my friend" }

puts "\n++++++  Test #2 my_each_with_index    ++++++"
friends.my_each_with_index { |friend, index| puts friend.to_s if index.odd? }

puts "\n++++++  Test #3 my_select   ++++++"
num.my_select { |x| puts x if x.even? }

p num.my_all?(&:odd?)
puts (%w[ant bear cat].my_all? { |word| word.length >= 3 })

puts '7.--------my_count--------'
puts (num.my_count { |x| (x % 2).zero? })
