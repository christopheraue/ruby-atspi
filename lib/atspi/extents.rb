module ATSPI
  # Wraps libatspi's AtspiRect[https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#AtspiRect-struct]
  class Extents
    extend Forwardable

    # @api private
    def initialize(native)
      @native = native
    end

    # @return [Integer] its x position
    delegate :x => :@native

    # @return [Integer] its y position
    delegate :y => :@native

    # @return [Integer] its width
    delegate :width => :@native

    # @return [Integer] its height
    delegate :height => :@native

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @x=#{x} @y=#{y} @width=#{width} @height=#{height}>"
    end
  end
end