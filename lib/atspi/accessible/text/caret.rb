module ATSPI
  class Accessible::Text
    # Represents the caret in a {Text}.
    class Caret < Offset
      # @api private
      def initialize(text_native)
        @text_native = text_native
      end

    # @!group Actions
      # @param offset [responds to #to_i]
      #
      # @return [true,false] indicating success
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-set-caret-offset atspi_text_set_caret_offset
      def move_to(offset)
        @text_native.set_caret_offset(offset.to_i)
      end
    # @!endgroup

    # @!group Representations
      # @return [Integer] its integer representation
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-get-caret-offset atspi_text_get_caret_offset
      def to_i
        @text_native.caret_offset
      end
    # @!endgroup
    end
  end
end