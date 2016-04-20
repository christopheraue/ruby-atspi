module ATSPI
  class Accessible::Text
    class Selection < Range
      extend Forwardable

      def initialize(text_native, idx)
        @text_native = text_native
        @idx = idx
        @range_native = @text_native.selection(idx)
      end

      def remove
        @text_native.remove_selection(@idx)
      end
      alias_method :destroy, :remove

      def move_start_to(start_offset)
        @text_native.set_selection(@idx, start_offset, end_offset)
      end

      def move_end_to(end_offset)
        @text_native.set_selection(@idx, start_offset, end_offset)
      end
    end
  end
end