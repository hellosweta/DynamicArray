require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if index < @length
      @store[(index + @start_idx) % @capacity]
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def []=(index, val)
    if index < @length
      @store[(index + @start_idx) % @capacity] = val
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def pop
    if @length < 1
      raise 'index out of bounds'
    else
      # start index = 4, capacity = 8, length = 4 [0, 1, 2, 3, 4, 5, 6, 7]
      popped = @store[((@start_idx + @length) % @capacity) - 1]
      @length -= 1
      popped
    end
  end

  # O(1) ammortized
  def push(val)
    if @capacity == @length
      resize!
    end
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1

  end

  # O(1)
  def shift
    if @length < 1
      raise 'index out of bounds'
    else
      first_value = @store[@start_idx]
      @start_idx = (@start_idx + 1) % @capacity
      @length -= 1

      first_value
    end

  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
    end
  #  if start index was 0, you'd want to change it to @capacity  - 1;
    new_start = (@start_idx - 1) % @capacity
    @store[new_start] = val
    @start_idx = new_start
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_array = StaticArray.new(@length * 2)
    i = @start_idx
    @length.times do |x|
      new_array[x] = @store[(@start_idx + x) % @capacity]
    end
    @store = new_array
    @start_idx = 0
    @capacity *= 2
  end
end
