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

  describe '#my_all' do
  end
end
