module ATSPI
  class Accessible::Hyperlink::Anchor
    def initialize(hyperlink_native, idx)
      @hyperlink_native = hyperlink_native
      @idx = idx
    end

    def uri
      @hyperlink_native.uri(@idx)
    end

    def object
      if object = @hyperlink_native.object(@idx)
        Accessible.new(object)
      end
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @uri=#{uri.inspect}>"
    end
  end
end