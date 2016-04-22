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
    alias_method :[], :at

    def count
      0
    end
    alias_method :size, :count
    alias_method :length, :count

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count}>"
    end
  end
end