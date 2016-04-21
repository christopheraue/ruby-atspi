class ATSPI::Accessible
  class Text
    class Hyperlink < Hyperlink
      def initialize(text_native, hyperlink_native)
        @text_native = text_native
        super(hyperlink_native)
      end

      def range
        Range.new(@text_native, @hyperlink_native.index_range)
      end
      alias_method :index_range, :range

      def start_offset
        Offset.new(@text_native, @hyperlink_native.start_index)
      end
      alias_method :start_index, :start_offset

      def end_offset
        Offset.new(@text_native, @hyperlink_native.end_index)
      end
      alias_method :end_index, :end_offset
    end
  end
end