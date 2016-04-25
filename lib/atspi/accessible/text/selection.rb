module ATSPI
  class Accessible::Text
    # Represents a selected range in a {Text}.
    class Selection < Range
      extend Forwardable

      # @api private
      def initialize(text_native, idx)
        @text_native = text_native
        @idx = idx
        @range_native = @text_native.selection(idx)
      end

    # @!group Actions
      # Deselects itself.
      #
      # @return [true,false] indicating success
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-remove-selection atspi_text_remove_selection
      def deselect
        @text_native.remove_selection(@idx)
      end

      # Moves its start to the given offset.
      #
      # @param new_start_offset [responds to #to_i]
      #
      # @return [true,false] indicating success
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-set-selection atspi_text_set_selection
      def move_start_to(new_start_offset)
        @text_native.set_selection(@idx, new_start_offset.to_i, self.end)
      end

      # Moves its end to the given offset.
      #
      # @param new_end_offset [responds to #to_i]
      #
      # @return [true,false] indicating success
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-text.html#atspi-text-set-selection atspi_text_set_selection
      def move_end_to(new_end_offset)
        @text_native.set_selection(@idx, start, new_end_offset.to_i)
      end
    # @!endgroup
    end
  end
end