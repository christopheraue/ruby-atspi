module ATSPI
  class Accessible::Children::Selected
    include SelectableCollection::Selected

  # @!visibility private
    def initialize(native)
      @native = native
    end
  # @!visibility public

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