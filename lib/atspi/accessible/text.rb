class ATSPI::Accessible
  class Text
    extend Forwardable
    include Editable
    include Hypertext

    def initialize(native)
      @native = native
    end

    delegate %i(character_count) => :@native
    alias_method :length, :character_count

    def text(from: 0, to: length)
      @native.text(from, to)
    end
    alias_method :value, :text
    alias_method :content, :text

    def caret
      Caret.new(@native)
    end

    def offset_at_point(x, y, relative_to:)
      Offset.new(@native, @native.offset_at_point(x, y, relative_to))
    end

    def bounded_ranges(x, y, width, height, relative_to:, clip_x:, clip_y:)
      @native.bounded_ranges(x, y, width, height, relative_to, clip_x, clip_y).map do |range|
        Range.new(@native, range)
      end
    end
    alias_method :ranges_in_extents, :bounded_ranges
    alias_method :ranges_in_rectangle, :bounded_ranges

    def selections
      @native.n_selections.times.map do |idx|
        Selection.new(@native, idx)
      end
    end
    delegate %i(add_selection) => :@native
    alias_method :select, :add_selection

    def inspect
      text_s = text[0..20] << (length > 20 ? '…' : '')
      "#<#{self.class.name}:0x#{'%x14' % __id__} @value=#{text_s.inspect} @length=#{length}>"
    end
  end
end