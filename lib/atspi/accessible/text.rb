class ATSPI::Accessible
  # Wraps libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html text interface},
  # {https://developer.gnome.org/libatspi/stable/libatspi-atspi-editabletext.html editable_text interface} and
  # {https://developer.gnome.org/libatspi/stable/libatspi-atspi-hypertext.html hypertext interface}.
  class Text
    extend Forwardable
    include Editable
    include Hypertext

    # @!visibility private
    def initialize(native)
      @native = native
    end
    # @!visibility public

  # @!group Attributes & States
    # @return [Integer] its length
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-character-count atspi_text_get_character_count
    def length
      @native.character_count
    end

    # @return [Caret] its caret/cursor
    def caret
      Caret.new(@native)
    end
    alias_method :cursor, :caret

    # @return [Array<Selection>] its selected text ranges
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-n-selections atspi_text_get_n_selections
    def selections
      @native.n_selections.times.map do |idx|
        Selection.new(@native, idx)
      end
    end
  # @!endgroup

  # @!group Geometric Access
    # @param x [Integer]
    # @param y [Integer]
    # @param relative_to [Symbol] coordinate system derived from
    #   libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCoordType AtspiCoordType enum}
    #   by removing the prefix +ATSPI_COORD_TYPE+ and making it lowercase
    #
    # @return [Offset] the offset at the given point
    #
    # @example
    #   text.offset_at(1243, 323, relative_to: :screen) # => #<ATSPI::Accessible::Text::Offset:0x112779814 … >
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-offset-at-point atspi_text_get_offset_at_point
    def offset_at(x, y, relative_to:)
      Offset.new(@native, @native.offset_at_point(x, y, relative_to))
    end

    # @param x [Integer] x position of the rectangle
    # @param y [Integer] y position of the rectangle
    # @param width [Integer] width of the rectangle
    # @param height [Integer] height of the rectangle
    # @param relative_to [Symbol] coordinate system derived from
    #   libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCoordType AtspiCoordType enum}
    #   by removing the prefix +ATSPI_COORD_TYPE+ and making it lowercase
    # @param clip_x [Symbol] how to treat characters intersecting the
    #   rectangle in x direction. derived from libatspi's
    #   {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiTextClipType AtspiTextClipType enum}
    #   by removing the prefix +ATSPI_TEXT_CLIP_+ and making it lowercase
    #
    # @return [Array<Range>] the ranges inside the given rectangle
    #
    # @example
    #   ranges_in(200, 300, 543, 322, relative_to: :window, clip_x: :both, clip_y: :min) # => [#<ATSPI::Accessible::Text::Range:0xea30bc14 … >, …]
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-bounded-ranges atspi_text_get_bounded_ranges
    def ranges_in(x, y, width, height, relative_to:, clip_x: :none, clip_y: :none)
      @native.bounded_ranges(x, y, width, height, relative_to, clip_x, clip_y).map do |range|
        Range.new(@native, range)
      end
    end
  # @!endgroup

  # @!group Actions
    # Selects the text between the given offsets.
    #
    # @param from [responds to #to_i] start offset
    # @param to [responds to #to_i] end offset
    #
    # @return [true,false] indicating success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-add-selection atspi_text_add_selection
    def select(from: 0, to: length)
      @native.add_selection(from.to_i, to.to_i)
    end

    # Deselects the entire text.
    #
    # To deselect a single selection do it via {Selection#deselect}.
    #
    # @return [true,false] indicating success
    def deselect
      selections.reverse.map(&:deselect).all?
    end
  # @!endgroup

  # @!group Representations
    # @param from [responds to #to_i] start offset
    # @param to [responds to #to_i] end offset
    #
    # @return [String] its string representation
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-text atspi_text_get_text
    def to_s(from: 0, to: length)
      @native.text(from.to_i, to.to_i)
    end

    # @return [String] itself as an inspectable string
    def inspect
      text_s = to_s(from: 0, to: 20) << (length > 20 ? '…' : '')
      "#<#{self.class.name}:0x#{'%x14' % __id__} @to_s=#{text_s.inspect} @length=#{length}>"
    end
  # @!endgroup
  end
end