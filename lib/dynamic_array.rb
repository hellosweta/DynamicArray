require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @logical_index = 0
    @physical_index = 0
    @length = 0

  end

  # O(1)
  def [](index)
    if index < @length
      @store[index]
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def []=(index, value)
    if index < @length
      @store[index] = value
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def pop
    if @length < 1
      raise 'index out of bounds'
    else
      @store[-@length]
      @length -= 1

    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @capacity == @length
      resize!
    else
      @store[@length] = val
    end
    @length += 1

  end

  # O(n): has to shift over all the elements.
  def shift
    if @length < 1
      raise 'index out of bounds'
    else
      first_value = @store[@logical_index]
      @logical_index = @logical_index += 1
      @length -= 1

      first_value
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity
      resize!
    end
    new_array = [val]
    i = 0
    while i < @length
      new_array.push(@store[i])
      i += 1
    end
    @store = new_array
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_array = StaticArray.new(@length * 2)
    i = 0
    while i < @length
      new_array[i] = @store[i]
      i += 1
    end
    @store = new_array
    @capacity *= 2
  end
end
