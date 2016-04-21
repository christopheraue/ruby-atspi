module ATSPI
  class Accessible::Text
    class Offset
      def initialize(text_native, offset)
        @text_native = text_native
        @offset = offset
      end

      attr_reader :offset

      def text_around(boundary)
        Range.new(@text_native, @text_native.string_at_offset(offset, boundary))
      end

      def character
        Character.new(@text_native, offset)
      end

      def hyperlink
        if @text_native.hypertext_iface
          idx = @text_native.link_index(offset)
          Hyperlink.new(@text_native.link(idx))
        end
      end
      alias_method :link, :hyperlink

      def inspect
        "#<#{self.class.name}:0x#{'%x14' % __id__} @offset=#{offset} " <<
          "@character=#{character.value.inspect} @text_around=#{text_around(:word).content.inspect}>"
      end
    end
  end
end