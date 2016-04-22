module ATSPI
  class Application < Accessible
    def path
      []
    end

    alias_method :desktop, :parent

    def application
      self
    end

    def window
      nil
    end

    alias_method :windows, :children

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @desktop=#{desktop.index} @name=#{name.inspect}>"
    end
  end
end