module ATSPI
  # Wraps the children part of libatspi's AtspiAccessible[https://developer.gnome.org/libatspi/stable/AtspiAccessible.html]
  # and parts of AtspiSelection[https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html].
  class Accessible::Children
    include SelectableCollection

    # @api private
    def initialize(native)
      @native = native
    end

  # @!group Enumerable interface
    # @param idx [Integer]
    #
    # @return [Accessible] its child at index +idx+
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-child-at-index atspi_accessible_get_child_at_index
    def at(idx)
      super do |mapped_idx|
        Accessible.new(@native.child_at_index(mapped_idx))
      end
    end

    # @return [Integer] its number of children
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-child-count atspi_accessible_get_child_count
    def count
      @native.child_count
    end
  # @!endgroup
  end
end