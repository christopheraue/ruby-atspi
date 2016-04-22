module ATSPI
  module Collection
    include Enumerable

    def each
      count.times.each do |idx|
        yield at(idx)
      end
    end
    
    def at(idx)
      nil
    end

    def [](*args)
      at(*args)
    end

    def count
      0
    end
    def size; count end
    def length; count end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count}>"
    end
  end
end