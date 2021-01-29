require_relative '../enumerable'

describe Enumerable do
  let(:num_array) { [1, 2, 3, 4, 5, 6, 7, 8] }
  let(:range) { (1..8) }
  let(:friends) { %w[Sharon Leo Leila Brian Arun] }

  describe '#my_each' do
    it 'returns an array adding 100 to each value' do
      ans = []
      num_array.each { |i| ans << i + 100 }
      expect(ans).to eq([101, 102, 103, 104, 105, 106, 107, 108])
    end

    it 'returns the given array' do
      expect(friends.my_each { |i| i }).to eq(friends)
    end

    it 'returns range not num_array' do
      expect(range.my_each { |i| i }).to_not eq(num_array)
    end

    it 'returns an enumerator if block not given' do
      expect(friends.my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    it 'returns the index of the array given' do
      res = []
      num_array.each_with_index { |_i, index| res << index }
      expect(res).to eq([0, 1, 2, 3, 4, 5, 6, 7])
    end

    it 'returns the given array' do
      expect(friends.my_each_with_index { nil }).to eq(friends)
    end

    it 'returns and enumerator if block not given' do
      expect(friends.my_each_with_index).to be_an Enumerator
    end
  end

  describe '#my_select' do
    it 'returns the sum of the items with 100' do
      res = []
      num_array.my_select { |i| res << i + 100 }
      expect(res).to eq([101, 102, 103, 104, 105, 106, 107, 108])
    end

    it 'to not returns the friends with Brian' do
      name = friends.my_select { |friend| friend != 'Brian' }
      expect(name).to_not eq(friends)
    end

    it 'returns enumerator if no block given' do
      expect(num_array.my_each_with_index).to be_an Enumerator
    end

    it 'returns the even numbers in the num_array' do
      res = num_array.my_select(&:even?)
      expect(res).to eq([2, 4, 6, 8])
    end
  end

  describe '#my_all?' do
    it 'returns true if the elements match' do
      res = friends.my_all? { |i| i.length >= 3 }
      expect(res).to be true
    end

    it 'returns false because numbers not greater than 10 in num_array' do
      res = num_array.my_all? { |i| i > 10 }
      expect(res).to be false
    end

    it 'returns false if block does not return true' do
      expect([true, nil, 50].my_all?).to eql(false)
    end

    it 'not to returns true if block does not return false' do
      expect([true, nil, 50].my_all?).to_not eql(true)
    end

    it 'returns false unless pattern is matched' do
      expect(friends.my_all?([/s/])).to eql(false)
    end
  end

  describe '#my_any' do
    it 'returns true if there are any match' do
      expect(num_array.my_any?(&:even?)).to be true
    end

    it 'returns true if there are any match' do
      expect(num_array.my_any?(&:odd?)).to_not be false
    end

    it 'returns false if the block does not return true' do
      expect(friends.my_any?([/s/])).to eql(false)
    end

    it 'returns true if any element matches' do
      expect([true, nil, 50].my_any?).to eql(true)
    end

    it 'returns true if the elements are strings' do
      expect(friends.my_any? { |i| i.is_a?(String) }).to_not be false
    end
  end

  describe '#my_none' do
    it 'returns true is block is not given only if none of the elements is true' do
      expect([].my_none?).to_not eq(false)
    end

    it 'returns false if we check for even items' do
      expect(num_array.my_none?(&:even?)).to be false
    end

    it 'returns false for false boolean' do
      expect([false, true, false].my_none?).to eq(false)
    end

    it 'return true for length greater than 3' do
      expect(friends.my_none? { |i| i.length >= 3 }).to_not be true
    end

    it 'returns false if there are no matches' do
      expect(friends.my_none? { |i| i.match(/T./) }).to_not be false
    end
  end

  describe '#my_count' do
    it 'should return the number of items in the range' do
      expect(range.my_count).to eq(8)
    end

    it 'returns the number of items in the array that are odd' do
      expect(range.my_count(&:even?)).to eq(4)
    end

    it 'returns the number of items in the array that are odd' do
      expect(range.my_count(&:odd?)).to_not eq(5)
    end

    it 'retuns the number of items in the array' do
      expect(friends.my_count).to eq(5)
    end
  end

  describe '#my_map' do
    it 'returns enumerator when no block is given' do
      expect(range.my_map).to be_instance_of(Enumerator)
    end

    it 'returns the friends name with th ' do
      res = []
      friends.my_map { |i| res << "#{i}th" }
      expect(res).to_not eq(%w[Sharon Leo Leila Brian Arun])
    end

    it 'returns the friends name with th ' do
      res = []
      friends.my_map { |i| res << "#{i}th" }
      expect(res).to eq(%w[Sharonth Leoth Leilath Brianth Arunth])
    end

    it 'returns the multiple of items by 5' do
      res = []
      range.my_map { |i| res << i * 5 }
      expect(res).to eq([5, 10, 15, 20, 25, 30, 35, 40])
    end
  end

  describe '#my_inject' do
    it 'returns the product of all the values in the array' do
      expect(num_array.my_inject(:*)).to eq(40_320)
    end

    it 'returns the sum of the values in the array' do
      expect(num_array.my_inject(0, :+)).to eq(36)
    end
  end
end
