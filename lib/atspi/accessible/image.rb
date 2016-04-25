module ATSPI
  # Wraps libatspi's AtspiImage[https://developer.gnome.org/libatspi/stable/libatspi-atspi-image.html]
  class Accessible::Image
    # @!visibility private
    def initialize(native)
      @native = native
    end
    # @!visibility public

    # @return [String] its description
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-image.html#atspi-image-get-image-description atspi_image_get_image_description
    def description
      @native.image_description
    end

    # @param (see Accessible::Extents#extents)
    # @return [Extents] its extents
    # @example (see Accessible::Extents#extents)
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-image.html#atspi-image-get-image-extents atspi_image_get_image_extents
    def extents(relative_to:)
      Extents.new(@native.image_extents(relative_to))
    end

    # @return [String] its locale
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-image.html#atspi-image-get-image-locale atspi_image_get_image_locale
    def locale
      @native.image_locale
    end

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @description=#{description.inspect} " <<
        "@extents=#{extents(relative_to: :screen).inspect}>"
    end
  end
end