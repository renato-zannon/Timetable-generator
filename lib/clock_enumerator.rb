class ClockEnumerator
  include Enumerable

  def initialize(arrays)
    raise ArgumentError, "Should be fed with array of arrays!" unless arrays.kind_of? Array
    raise ArgumentError, "Argument shouldn't be empty!" if arrays.empty?
    arrays.each { |array| raise ArgumentError, "Should be fed with array of arrays!" unless array.kind_of? Array }
    @arrays = arrays
  end

  def each(&block)
    all.each &block
  end

  def all
    @all ||= if @arrays.count > 1
               @arrays.inject { |combination, array| combination.product(array) }.map(&:flatten)
             else
               @arrays.flatten.zip
             end
  end

  def last
    @arrays.map(&:last)
  end

end
