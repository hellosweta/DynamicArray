# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    if index <= @store.length && index >= -1 * @store.length
      @store[index]
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def []=(index, value)
    if index <= @store.length
      @store[index] = value
    else
      raise 'index out of bounds'
    end
  end

  protected
  attr_accessor :store
end
