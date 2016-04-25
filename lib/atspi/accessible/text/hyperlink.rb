class ATSPI::Accessible
  class Text
    # Represents a hyperlink in a {Text}.
    class Hyperlink < Hyperlink
      # @api private
      def initialize(text_native, native)
        @text_native = text_native
        super(native)
      end

      # @return [Range] its range
      #
      # @see https://developer.gnome.org/libatspi/stable/AtspiHyperlink.html#atspi-hyperlink-get-index-range atspi_hyperlink_get_index_range
      def range
        Range.new(@text_native, @native.index_range)
      end
    end
  end
end