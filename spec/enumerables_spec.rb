require './enumerable.rb'

describe Enumerable do
  let(:array) { [1, 3, 5, 6] }
  let(:range) { (1..8) }
  let(:string_array) { %w[cat yam dog yam] }

  describe '#my_each' do
    it 'returns muliplication of each element in the array' do
      result = []
      array.my_each { |x| result << x * 2 }
      expect(result).to eq([2, 6, 10, 12])
    end
  end

  it 'should return the original array' do
    expect(string_array.my_each { |x| x }).to eq(string_array)
  end

  it 'it should return enumerator if block is not given' do
    expect(array.my_each).to be_an Enumerator
  end
end
