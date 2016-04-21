module ATSPI
  class Accessible::Children::Selected
    include Enumerable

    def initialize(native)
      @native = native
    end

    def each
      count.times.each do |idx|
        yield at(idx)
      end
    end

    def at(idx)
      Accessible.new(@native.selected_child(idx))
    end
    alias_method :[], :at

    def count
      @native.n_selected_children
    end
    alias_method :size, :count
    alias_method :length, :count

    def inspect
      indices = first(5).map(&:index_in_parent).inspect
      indices[-1] = ", …]" if count > 5
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @indices=#{indices}>"
    end
  end
end