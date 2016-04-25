module ATSPI
  class Accessible::Text
    # Represents a single character in a {Text}.
    class Character
      # @api private
      def initialize(native, offset)
        @native = native
        @offset = offset
      end

    # @!group Attributes
      # @return [1] its length
      def length
        1
      end

      # @param relative_to [Symbol] coordinate system derived from
      #   libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCoordType AtspiCoordType enum}
      #   by removing the prefix +ATSPI_COORD_TYPE+ and making it lowercase
      #
      # @return [Extents] its extents
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-character-extents atspi_text_get_character_extents
      def extents(relative_to:)
        Extents.new(@native.character_extents(@offset, relative_to))
      end
    # @!endgroup

    # @!group Representations
      # @return [String] its string representation
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-character-at-offset atspi_text_get_character_at_offset
      def to_s
        [@native.character_at_offset(@offset)].pack("U") # UCS-4 codepoint to readable character
      end

      # @return [String] itself as an inspectable string
      def inspect
        "#<#{self.class.name}:0x#{'%x14' % __id__} @to_s=#{to_s.inspect} @length=#{length} " <<
          "@offset=#{@offset} @extents=#{extents(relative_to: :screen).inspect}>"
      end
    # @!endgroup
    end
  end
end