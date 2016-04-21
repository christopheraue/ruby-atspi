module ATSPI
  class Accessible::Component
    extend Forwardable

    def initialize(native)
      @native = native
    end

    delegate %i(contains) => :@native
    delegate %i(layer mdi_z_order) => :@native
    delegate %i(grab_focus) => :@native
    delegate %i(alpha) => :@native

    alias_method :contains?, :contains

    def accessible_at_point(x, y, relative_to:)
      Accessible.new(@native.accessible_at_point(x, y, relative_to))
    end

    def extents(relative_to:)
      Extents.new(@native.extents(relative_to))
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @extents=#{extents(relative_to: :screen).inspect}>"
    end
  end
end