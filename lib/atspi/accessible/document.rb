class ATSPI::Accessible
  # Wraps libatspi's AtspiDocument[https://developer.gnome.org/libatspi/stable/libatspi-atspi-document.html]
  class Document
    # @!visibility private
    def initialize(native)
      @native = native
    end
    # @!visibility public

    # @return [String] its locale
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-document.html#atspi-document-get-locale atspi_document_get_locale
    def locale
      @native.locale
    end

    # @return [Hash<String => String>] its attributes
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-document.html#atspi-document-get-attributes atspi_document_get_attributes
    def attributes
      @native.document_attributes.to_h
    end

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} #{attributes.map{ |k, v| "@#{k}=#{v.inspect}" }.join(' ')}>"
    end
  end
end