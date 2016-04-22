module ATSPI
  module Collection
    include Enumerable

    def each
      count.times.each do |idx|
        yield at(idx)
      end
    end
    
    def at(idx)
      if idx.between?(0, count-1)
        yield idx
      elsif idx.between?(-count, -1)
        yield count+idx
      else
        nil
      end
    end

    def [](*args)
      at(*args)
    end

    def count
      0
    end
    def size; count end
    def length; count end

    def last(n = 1)
      if n > 1
        [n,count].min.downto(1).map{ |idx| at(-idx) }
      else
        at(-1)
      end
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count}>"
    end
  end
end