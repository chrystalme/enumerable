require './enumerable.rb'

describe Enumerable do
  let(:array) { [1, 3, 5, 7] }
  let(:range) { (1..8) }
  let(:string_array) { %w[cat yam dog yam] }

  describe '#my_each' do
    it 'returns muliplication of each element in the array' do
      result = []
      array.my_each { |x| result << x * 2 }
      expect(result).to eq([2, 6, 10, 14])
    end

    it 'should return the original array' do
      expect(string_array.my_each { |x| x }).to eq(string_array)
    end

    it 'it should return enumerator if block is not given' do
      expect(array.my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    it 'Should return the index of the array' do
      result = []
      array.my_each_with_index { |_x, index| result << index }
      expect(result).to eq([0, 1, 2, 3])
    end

    it 'should return enumerable when a block is not given' do
      expect(array.my_each_with_index).to be_an Enumerator
    end

    it 'returnd the original array with no block passed' do
      expect(array.my_each_with_index { nil }).to eq(array)
    end
  end

  describe '#my_select' do
    it 'should return the square of each number' do
      result = []
      array.my_select { |x| result << x * 2 }
      expect(result).to eq([2, 6, 10, 14])
    end

    it 'return enumerator with no block passed' do
      expect(array.my_select).to be_an Enumerator
    end

    it 'return the selected value' do
      result = array.my_select { |x| x == 7 }
      expect(result).to eq([7])
    end

    it 'returns even elements' do
      result = array.my_select(&:even?)
      expect(result).to eq([])
    end

    it 'returns even elements' do
      result = array.my_select(&:even?)
      expect(result).to eq([])
    end
  end

  describe '#my_all?' do
    it 'checks elemens with the length of 3' do
      result = string_array.my_all? { |x| x.length == 3 }
      expect(result).to be_truthy
    end

    it 'checks if all numbers are odd' do
      result = array.my_all?(&:odd?)
      expect(result).to be_truthy
    end

    it 'checks if all numbers are divisble by 3' do
      result = array.my_all? { |x| x % 3 == 0 }
      expect(result).to be_falsey
    end
  end

  describe '#my_any?' do
    it 'checks all the odd numbers' do
      expect(array.my_any?(&:odd?)).to be_truthy
    end

    it 'checks if any of the elements are divisible by 5' do
      result = array.my_any? { |x| x % 5 == 0 }
      expect(result).to be_truthy
    end

    it 'checks if any of the elements have length of 3' do
      result = string_array.my_any? { |x| x.length == 3 }
      expect(result).to be_truthy
    end
  end

  describe '#my_none?' do
    it 'it should return true for even numbers' do
      expect(array.my_none?(&:even?)).to be_truthy
    end

    it 'it returns false for length of 3' do
      expect(string_array.my_none? { |x| x.length == 3 }).to be_falsey
    end

    it 'it returns false for false boolean' do
      expect([true, false, true].my_none?).to be_falsey
    end

    it 'it should return true' do
      expect(string_array.my_none?('z')).to be_truthy
    end
  end

  describe 'my_count' do
    it 'returns the number of elemnts in the array' do
      expect(array.my_count).to eq(4)
    end

    it 'returns number of elements divisble by 2' do
      expect(array.my_count(&:even?)).to eq(0)
    end

    it 'return the arrays lenth when no block is given' do
      expect(string_array.my_count).to eq(4)
    end
  end
end
