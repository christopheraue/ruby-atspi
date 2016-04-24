module ATSPI
  class Accessible::Text
    # Represents a range in a {Text}.
    class Range
      extend Forwardable

      # @!visibility private
      def initialize(text_native, range_native)
        @text_native = text_native
        @range_native = range_native
      end
      # @!visibility public

    # @!group Attributes
      # @return [Offset] its start offset
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#AtspiRange-struct struct AtspiRange
      def start
        Offset.new(@text_native, @range_native.start_offset)
      end

      # @return [Offset] its end offset
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#AtspiRange-struct struct AtspiRange
      def end
        Offset.new(@text_native, @range_native.end_offset)
      end

      # @return [Integer] its length
      def length
        self.end.to_i - start.to_i
      end

      # @param relative_to [Symbol] coordinate system derived from
      #   libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCoordType AtspiCoordType enum}
      #   by removing the prefix +ATSPI_COORD_TYPE+ and making it lowercase
      #
      # @return [Extents] its extents
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-range-extents atspi_text_get_range_extents
      def extents(relative_to:)
        Extents.new(@text_native.range_extents(start.to_i, self.end.to_i, relative_to))
      end
    # @!endgroup

    # @!group Representations
      # @return [String] its string representation
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#AtspiTextRange-struct struct AtspiTextRange
      def to_s
        if @range_native.respond_to? :content
          @range_native.content
        else
          @text_native.text(start.to_i, self.end.to_i)
        end
      end

      # @return [String] itself as an inspectable string
      def inspect
        text_s = to_s[0..20] << (length > 20 ? '…' : '')
        "#<#{self.class.name}:0x#{'%x14' % __id__} @to_s=#{text_s.inspect} @length=#{length} " <<
          "@start=#{start} @end=#{self.end} @extents=#{extents(relative_to: :screen).inspect}>"
      end
    # @!endgroup
    end
  end
end