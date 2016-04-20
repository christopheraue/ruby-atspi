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

    def accessible_at_point(x, y, type)
      Accessible.new(@native.accessible_at_point(x, y, type))
    end

    def extents(relative_to)
      Rect.new(@native.extents(relative_to))
    end

    def position(relative_to)
      Point.new(@native.position(relative_to))
    end

    def size(relative_to)
      Point.new(@native.size(relative_to))
    end

    def x(relative_to)
      extents(relative_to).x
    end
    alias_method :left, :x

    def y(relative_to)
      extents(relative_to).y
    end
    alias_method :top, :y

    def width(relative_to)
      extents(relative_to).width
    end

    def height(relative_to)
      extents(relative_to).height
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @x=#{x(:screen)} @y=#{y(:screen)} " <<
        "@width=#{width(:screen)} @height=#{height(:screen)}>"
    end
  end
end