module ATSPI
  class Window < Accessible
    def path
      []
    end

    alias_method :parent, :application

    def window
      self
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @desktop=#{desktop.index} " <<
        "@application=#{application.name} @name=#{name.inspect} " <<
        "@extents=#{extents(relative_to: :screen).inspect}>"
    end
  end
end