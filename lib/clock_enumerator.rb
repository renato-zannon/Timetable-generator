class ClockEnumerator
  include Enumerable

  def initialize(arrays, &validity_check)
    raise ArgumentError, "Should be fed with array of arrays!" unless arrays.kind_of? Array
    raise ArgumentError, "Argument shouldn't be empty!" if arrays.empty?
    arrays.each { |array| raise ArgumentError, "Should be fed with array of arrays!" unless array.kind_of? Array }
    @arrays = arrays.sort_by(&:count)
    @validity_check = validity_check || Proc.new { true }
  end

  def each(&block)
    all.each &block
  end

  def all
    return @all unless @all.nil?
    return (@all = @arrays.flatten.zip) if @arrays.count==1

    @all = @arrays[0].dup
    (1...@arrays.length).to_a.each do |num|
      @all = @all.product(@arrays[num]).map(&:flatten).select { |array| valid?(array) }
    end
    @all
  end

  def last
    @arrays.map(&:last)
  end

  def valid?(array)
    @validity_check.call(array)
  end
end
