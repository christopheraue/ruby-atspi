class ATSPI::Accessible
  # Wraps libatspi's AtspiSelection[https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html]
  # together with parts of {Children} and {Children::Selected}
  module Selectable
  # @!group Attributes & States
    # Checks if it can be selected. Accessibles which parent's native
    # implements the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}
    # are selectable.
    #
    # @return [true, false]
    def selectable?
      parent.children.selectable?
    end
  # @!endgroup

  # @!group Actions
    # Selects it
    # @return [true, false] indicating success of the operation. +false+ if its
    #   parent does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html#atspi-selection-select-child atspi_selection_select_child
    def select
      selectable? and parent.__send__(:native).select_child(index_in_parent)
    end

    # Deselects it
    # @return [true, false] indicating success of the operation. +false+ if its
    #   parent does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html#atspi-selection-deselect-child atspi_selection_deselect_child
    def deselect
      selectable? and parent.__send__(:native).deselect_child(index_in_parent)
    end
  # @!endgroup

  # @!group Attributes & States
    # Checks if it currently is selected
    # @return [true, false] +false+ if its
    #   parent does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html#atspi-selection-is-child-selected atspi_selection_is_child_selected
    def selected?
      selectable? and parent.__send__(:native).is_child_selected(index_in_parent)
    end
  # @!endgroup
  end
end