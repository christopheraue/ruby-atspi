module ATSPI
  # Wraps libatspi's AtspiSelection[https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html]
  # together with parts of {Selectable} and {Children}
  #
  # Instance are enumerables supporting item access and can be treated more or
  # less like an array.
  class Accessible::Children::Selected
    include SelectableCollection::Selected

  # @api private
    def initialize(native)
      @native = native
    end

  # @!group Enumerable interface
    # @param idx [Integer]
    #
    # @return [Accessible] its child at index +idx+
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html#atspi-selection-get-selected-child atspi_selection_get_selected_child
    def at(idx)
      super do |mapped_idx|
        Accessible.new(@native.selected_child(mapped_idx))
      end
    end

    # @return [Integer] its number of children
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html#atspi-selection-get-n-selected-children atspi_selection_get_n_selected_children
    def count
      @native.n_selected_children
    end
  # @!endgroup
  end
end