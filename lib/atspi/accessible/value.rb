module ATSPI
  class Accessible::Value
    extend Forwardable

    # @!visibility private
    def initialize(native)
      @native = native
    end
    # @!visibility public

    # @return [Float] its minimum
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-value.html#atspi-value-get-minimum-value atspi_value_get_minimum_value
    def minimum
      @native.minimum_value
    end

    # @return [Float] its maximum
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-value.html#atspi-value-get-maximum-value atspi_value_get_maximum_value
    def maximum
      @native.maximum_value
    end

    # @return [Float] its current value
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-value.html#atspi-value-get-current-value atspi_value_get_current_value
    def current
      @native.current_value
    end

    # Sets its value to the given one.
    # @return [true,false] indicating success
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-value.html#atspi-value-set-current-value atspi_value_set_current_value
    def set_to(value)
      @native.set_current_value(value)
    end

    # @return [Float] its minimum increment
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-value.html#atspi-value-get-minimum-increment atspi_value_get_minimum_increment
    def step
      @native.minimum_increment
    end

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @min=#{min} @cur=#{cur} @max=#{max} @incr=#{incr}>"
    end
  end
end