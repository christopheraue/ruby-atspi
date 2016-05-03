module ATSPI
  # Included in classes representing a collection that can be iterated over.
  # A Collection is an Enumerable adjusted to the what we can efficiently get
  # from libatspi. In particular, it provides access to items by index and
  # from the end of the collection and can be treated like an array.
  module Collection
    include Enumerable
  # @!group Enumerable interface
    # prerequisite for Enumerable
    def each
      count.times.each do |idx|
        yield at(idx)
      end
    end

    # @param idx [Integer]
    # @return [Object] item at index +idx+
    def at(idx)
      if idx.between?(0, count-1)
        yield idx
      elsif idx.between?(-count, -1)
        yield count+idx
      else
        nil
      end
    end

    # alias for {#at}
    def [](idx)
      at(idx)
    end

    # @return [0] default size of collection
    def count
      0
    end
    # alias for {#count}
    def size; count end
    # alias for {#count}
    def length; count end

    # @param n [Integer] number of items to return
    # @return [Object,Array<Object>] item(s) from the end
    def last(n = 1)
      if n > 1
        [n,count].min.downto(1).map{ |idx| at(-idx) }
      else
        at(-1)
      end
    end
  # @!endgroup

  # @!group Representation
    # @return [String] instance as inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count}>"
    end
  # @!endgroup
  end
end