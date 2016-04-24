module ATSPI
  class Accessible::Text
    # Represents an offset in a {Text}.
    class Offset
      # @!visibility private
      def initialize(text_native, offset)
        @text_native = text_native
        @offset = offset
      end
      # @!visibility public

    # @!group Attributes
      # @param boundary [Symbol] the boundary type derived from libatspi's
      #   {https://github.com/GNOME/at-spi2-core/blob/9439376bc09333e6baf7111d5246a7beff1f7a14/atspi/atspi-constants.h#L348 AtspiTextGranularity enum}
      #   by removing the prefix +ATSPI_TEXT_GRANULARITY_+ and making it lowercase
      #
      # @return [Range] the text between the closest boundary to the left and
      #   right
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-text-at-offset atspi_text_get_string_at_offset
      def text_around(boundary)
        Range.new(@text_native, @text_native.string_at_offset(to_i, boundary))
      end

      # @return [Character] its character
      def character
        Character.new(@text_native, to_i)
      end

      # @return [Hyperlink,nil] its hyperlink. Will be +nil+ if its text does
      #   not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-hypertext hypertext interface}
      #   or there simply is no hyperlink at the offset.
      #
      # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-hypertext atspi_accessible_get_hypertext
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-hypertext.html#atspi-hypertext-get-link-index atspi_hypertext_get_link_index
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-hypertext.html#atspi-hypertext-get-link atspi_hypertext_get_link
      def hyperlink
        if @text_native.hypertext_iface
          idx = @text_native.link_index(to_i)
          Hyperlink.new(@text_native, @text_native.link(idx)) if idx != -1
        end
      end
      alias_method :link, :hyperlink
    # @!endgroup

    # @!group Representations
      # @return [Integer] its integer representation
      def to_i
        @offset
      end

      # @return [String] itself as an inspectable string
      def inspect
        "#<#{self.class.name}:0x#{'%x14' % __id__} @to_i=#{to_i} " <<
          "@character=#{character.to_s.inspect} @text_around=#{text_around(:word).to_s.inspect}>"
      end
    # @!endgroup
    end
  end
end