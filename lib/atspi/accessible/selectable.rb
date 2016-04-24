class ATSPI::Accessible
  module Selectable
  # @!group Selection
    # Checks if it can be selected. Accessibles which parent's native
    # implements the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}
    # are selectable.
    #
    # @return [true, false]
    def selectable?
      parent.children.selectable?
    end

    # Selects it
    # @return [true, false] indicating success of the operation. +false+ if its
    #   parent does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}.
    def select
      selectable? and parent.__send__(:native).select_child(index_in_parent)
    end

    # Deselects it
    # @return [true, false] indicating success of the operation. +false+ if its
    #   parent does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}.
    def deselect
      selectable? and parent.__send__(:native).deselect_child(index_in_parent)
    end

    # Checks if it currently is selected
    # @return [true, false] +false+ if its
    #   parent does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection selection interface}.
    def selected?
      selectable? and parent.__send__(:native).is_child_selected(index_in_parent)
    end
  # @!endgroup
  end
end