module ATSPI
  class Accessible::Component::Point
    extend Forwardable

    def initialize(native)
      @native = native
    end

    delegate %i(x y) => :@native
    alias_method :left, :x
    alias_method :top, :y

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @x=#{x} @y=#{y}>"
    end
  end
end