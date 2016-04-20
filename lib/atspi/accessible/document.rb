class ATSPI::Accessible
  class Document
    def initialize(native)
      @native = native
    end

    def locale
      @native.locale
    end

    def attribute_value(attribute)
      @native.document_attribute_value(attribute.to_s)
    end

    def attributes
      @native.document_attributes.to_h
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} #{attributes.map{ |k, v| "@#{k}=#{v.inspect}" }.join(' ')}>"
    end
  end
end