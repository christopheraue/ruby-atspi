module ATSPI
  class Accessible::Image
    def initialize(native)
      @native = native
    end

    def description
      @native.image_description
    end

    def extents(relative_to:)
      Extents.new(@native.image_extents(relative_to))
    end

    def locale
      @native.image_locale
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @description=#{description.inspect} " <<
        "@extents=#{extents(relative_to: :screen).inspect}>"
    end
  end
end