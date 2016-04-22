module ATSPI
  class Desktop < Accessible
    def parent
      nil
    end

    def path
      []
    end

    def desktop
      self
    end

    def application
      nil
    end

    def window
      nil
    end

    alias_method :applications, :children

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @index=#{index} @name=#{name.inspect}>"
    end
  end
end