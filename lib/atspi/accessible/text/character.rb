module ATSPI
  class Accessible::Text
    class Character
      def initialize(text_native, offset)
        @text_native = text_native
        @offset = offset
      end

      def value
        [@text_native.character_at_offset(@offset)].pack("U") # UCS-4 codepoint to readable character
      end
      alias_method :content, :value
      alias_method :text, :value

      def length
        1
      end

      def extents(relative_to:)
        Extents.new(@text_native.character_extents(@offset, relative_to))
      end

      def inspect
        "#<#{self.class.name}:0x#{'%x14' % __id__} @content=#{content.inspect} @length=#{length} " <<
          "@offset=#{@offset} @extents=#{extents(relative_to: :screen).inspect}>"
      end
    end
  end
end