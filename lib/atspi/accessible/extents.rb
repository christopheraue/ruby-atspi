class ATSPI::Accessible
  # Wraps libatspi's AtspiComponent[https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html]
  module Extents
  # @!group Attributes & States
    # Checks if it is extending, that is it has a position and size.
    # Accessibles implementing the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-component component interface}
    # are extending.
    #
    # @return [true, false]
    def extends?
      not @native.component_iface.nil?
    end

    # @return [Symbol] its layer derived from libatspi's {AtspiComponentLayer enum}[https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiComponentLayer]
    #   by removing the prefix +ATSPI_LAYER_+ and making it lowercase. +:invalid+
    #   if it does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-component component interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#atspi-component-get-layer atspi_component_get_layer
    def layer
      if extends?
        @native.layer
      else
        :invalid
      end
    end

    # @return [Integer] its mdi_z_order. +-1+ if it does not implement the
    #   {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-component component interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#atspi-component-get-mdi-z-order atspi_component_get_mdi_z_order
    def mdi_z_order
      if extends?
        @native.mdi_z_order
      else
        -1
      end
    end
  # @!endgroup

  # @!group Actions
    # Sets the input focus to it.
    #
    # @return [true, false] indicating success of the operation. +false+ if it
    #   does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-component component interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#atspi-component-grab-focus atspi_component_grab_focus
    def grab_focus
      extends? and @native.grab_focus
    end
  # @!endgroup

  # @!group Attributes & States
    # @return [Float] its opacity between +0.0+ (transparent) and +1.0+ (opaque). +0.0+
    #   if it does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-component component interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#atspi-component-get-alpha atspi_component_get_alpha
    def opacity
      if extends?
        @native.alpha
      else
        0.0
      end
    end
    alias_method :alpha, :opacity

    # Checks if the given point lies within its bounds
    #
    # @param x [Integer]
    # @param y [Integer]
    # @param relative_to [Symbol] coordinate system derived from
    #   libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCoordType AtspiCoordType enum}
    #   by removing the prefix +ATSPI_COORD_TYPE+ and making it lowercase
    #
    # @return [true, false]
    #
    # @example
    #   accessible.contains?(1243, 323, relative_to: :screen) # => true
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#atspi-component-contains atspi_component_contains
    def contains?(x, y, relative_to:)
      extends? and @native.contains(x, y, relative_to)
    end
  # @!endgroup

  # @!group Tree & Traversal
    # @param x [Integer]
    # @param y [Integer]
    # @param relative_to [Symbol] coordinate system derived from
    #   libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCoordType AtspiCoordType enum}
    #   by removing the prefix +ATSPI_COORD_TYPE+ and making it lowercase
    #
    # @return [Accessible, nil] the descendant at the given coordinates. +nil+
    #   if it does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-component component interface}.
    #
    # @example
    #   accessible.descendant_at(1243, 323, relative_to: :screen) # => #<ATSPI::Accessible:0x140839014 …>
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#atspi-component-get-accessible-at-point atspi_component_get_accessible_at_point
    def descendant_at(x, y, relative_to:)
      if extends?
        ATSPI::Accessible.new(@native.accessible_at_point(x, y, relative_to))
      else
        nil
      end
    end
  # @!endgroup

  # @!group Attributes & States
    # @param relative_to [Symbol] coordinate system derived from
    #   libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCoordType AtspiCoordType enum}
    #   by removing the prefix +ATSPI_COORD_TYPE_+ and making it lowercase
    #
    # @return [ATSPI::Extents] its extents. Will have a (0,0) position and a
    #   0x0 size if it does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-component component interface}.
    #
    # @example
    #   accessible.extents(relative_to: :screen) # => #<ATSPI::Extents:0x10b62c814 @x=2192 @y=187 @width=655 @height=492>
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-component.html#atspi-component-get-extents atspi_component_get_extents
    def extents(relative_to:)
      if extends?
        ATSPI::Extents.new(@native.extents(relative_to))
      else
        ATSPI::Extents.new(Struct.new(:x, :y, :width, :height).new(0, 0, 0, 0))
      end
    end
  # @!endgroup
  end
end