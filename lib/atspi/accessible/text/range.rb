module ATSPI
  class Accessible::Text
    class Range
      extend Forwardable

      def initialize(text_native, range_native)
        @text_native = text_native
        @range_native = range_native
      end

      delegate %i(start_offset end_offset) => :@range_native

      def length
        end_offset - start_offset
      end

      def content
        if @range_native.respond_to? :content
          @range_native.content
        else
          @text_native.text(start_offset, end_offset)
        end
      end
      alias_method :value, :content
      alias_method :text, :content

      def extents(relative_to)
        Extents.new(@text_native.range_extents(start_offset, end_offset, relative_to))
      end

      def inspect
        text_s = value[0..20] << (length > 20 ? '…' : '')
        "#<#{self.class.name}:0x#{'%x14' % __id__} @content=#{text_s.inspect} @length=#{length} " <<
          "@start_offset=#{start_offset} @end_offset=#{end_offset} @extents=#{extents(:screen).inspect}>"
      end
    end
  end
end