# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  # 1 my_each
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  # 2 my_each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  # 3 my_select
  def my_select
    return to_enum unless block_given?

    my_arr = []
    my_each { |item| my_arr << item if yield item }
    my_arr
  end

  # 4 my_all
  def my_all?(param = nil)
    if block_given?
      my_each { |i| return false if yield(i) == false }
      true
    elsif param.nil?
      my_each { |i| return false if i.nil? || i == false }
    elsif !param.nil? && (param.is_a? Class)
      my_each { |i| return false unless [i.class, i.class.superclass].include?(param) }
    elsif !param.nil? and param.instance_of?(Regexp)
      my_each { |i| return false unless param.match(i) }
    else
      my_each { |i| return false if i != param }
    end
    true
  end

  # 5 my_any
  def my_any?(param = nil)
    if param.nil?
      if block_given?
        my_each { |i| return true if yield(i) }
      else my_each { |i| return true if i }
      end
    elsif param.is_a?(Regexp)
      my_each { |i| return true if i.match(param) }
    elsif param.is_a?(Module)
      my_each { |i| return true if i.is_a?(param) }
    else
      my_each { |i| return true if i == param }
    end
    false
  end

  # 6 my_none
  def my_none?(param = nil)
    if param.nil?
      if block_given?
        my_each { |i| return false if yield(i) }
      else my_each { |i| return false if i }
      end
    elsif param.is_a?(Regexp)
      my_each { |i| return false if i.match(param) }
    elsif param.is_a?(Module)
      my_each { |i| return false if i.is_a?(param) }
    else
      my_each { |i| return false if i == param }
    end
    true
  end

  # 7 my_count
  def my_count(param = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif !block_given? && param.nil?
      count = to_a.length
    else
      count = to_a.my_select { |i| i == param }.length
    end
    count
  end

  # 8 my_map
  def my_map(proc = nil)
    return to_enum unless block_given? || !proc.nil?

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
    return raise LocalJumpError, '**No block given**' if !block_given? && initial.nil? && symb.nil?

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

  # 10 my_map_proc
  def my_map_proc
    my_arr = []
    if block_given?
      my_each do |i|
        my_arr << yield(i)
      end
    else
      to_enum(:my_map_proc)
    end
    my_arr
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

# 11 multiply_els
def multiply_els(arr)
  arr.my_inject(1, '*')
end
