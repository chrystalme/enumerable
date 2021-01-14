module Enumerable
  def my_each
    to_enum(:my_each) unless block_given?  
             
   i = 0
   while i < to_a.length
    yield to_a[i]
    i += 1
   end
  #  self
  end

  def my_each_with_index
    to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
     yield(to_a[i], i)
     i += 1
    end
    # self
   end

   def my_select
    my_arr = []
    to_a.my_each {|item| my_arr << item if yield item}
    my_arr
   end
  





    
end

# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
num = [1,2,3,4,5,6,7,8]

num.my_each{|i| puts i*2 }