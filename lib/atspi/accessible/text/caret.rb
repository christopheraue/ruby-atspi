module ATSPI
  class Accessible::Text
    class Caret < Offset
      def initialize(text_native)
        @text_native = text_native
      end

      def offset
        @text_native.caret_offset
      end

      def offset=(offset)
        @text_native.set_caret_offset(offset)
      end
    end
  end
end