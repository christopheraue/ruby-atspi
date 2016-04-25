module ATSPI
  # Wraps libatspi's AtspiHyperlink[https://developer.gnome.org/libatspi/stable/AtspiHyperlink.html]
  # together with {Hyperlink}.
  class Accessible::Hyperlink::Anchor
    # @api private
    def initialize(native, idx)
      @native = native
      @idx = idx
    end

    # @return [String] its uri
    # @see https://developer.gnome.org/libatspi/stable/AtspiHyperlink.html#atspi-hyperlink-get-uri atspi_hyperlink_get_uri
    def uri
      @native.uri(@idx)
    end

    # @return [Accessible,nil] its object or nil if it has none
    # @see https://developer.gnome.org/libatspi/stable/AtspiHyperlink.html#atspi-hyperlink-get-object atspi_hyperlink_get_object
    def object
      if object = @native.object(@idx)
        Accessible.new(object)
      end
    end

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @uri=#{uri.inspect}>"
    end
  end
end