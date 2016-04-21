module ATSPI
  class Accessible::Children
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
      Accessible.new(@native.child_at_index(idx))
    end
    alias_method :[], :at

    def count
      @native.child_count
    end
    alias_method :size, :count
    alias_method :length, :count

    def selectable?
      not @native.selection_iface.nil?
    end

    def selected
      if selectable?
        Selected.new(@native)
      else
        []
      end
    end

    def select_all
      selectable? and @native.select_all
    end

    def clear_selection
      selectable? and @native.clear_selection
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @selectable?=#{selectable?} " <<
        "@selected=#{selected.inspect}>"
    end
  end
end