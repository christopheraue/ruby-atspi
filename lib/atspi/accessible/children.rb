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

  # @!group Selection
    # Checks if the accessible the children belong to implements the selection
    # interface.
    #
    # @return [true,false]
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-selection atspi_accessible_get_selection
    def selectable?
      not @native.selection_iface.nil?
    end

    # @return [Selected,[]] its selected subset. It will be an empty array if
    #   children are not selectable.
    def selected
      if selectable?
        Selected.new(@native)
      else
        []
      end
    end

    # Tries to select all children
    #
    # @return [true,false] indicates success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html#atspi-selection-select-all atspi_selection_select_all
    def select_all
      selectable? and @native.select_all
    end

    # Tries to deselect all children
    #
    # @return [true,false] indicates success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-selection.html#atspi-selection-clear-selection atspi_selection_clear_selection
    def deselect_all
      selectable? and @native.clear_selection
    end
  # @!endgroup

  # @!group Filter
    # @note (see Descendants#where)
    # @see (see Descendants#where)
    # @return [Descendants] the children collection as filtered descendants
    #   collection.
    # @overload (see Descendants#where)
    def where(*args)
      Accessible::Descendants.new(@native).recursive(false).where(*args)
    end
  # @!endgroup

  # @!group Options
    # @param (see Descendants#sort_by)
    # @return [Descendants] the children collection as sorted descendants
    #   collection.
    # @example (see Descendants#sort_by)
    # @see (see Descendants#sort_by)
    def sort_by(order)
      Accessible::Descendants.new(@native).recursive(false).sort_by(order)
    end

    # @param (see Descendants#limit_to)
    # @return [Descendants] the children collection as limited descendants
    #   collection.
    # @see (see Descendants#limit_to)
    def limit_to(limit)
      Accessible::Descendants.new(@native).recursive(false).limit_to(limit)
    end

    # @param (see Descendants#recursive)
    # @return [Descendants,self] self if +recursive+ is set to +false+. A
    #   collection of all descendants if +recursive+ is set to +true+
    # @see (see Descendants#recursive)
    def recursive(recursive = true)
      if recursive
        Accessible::Descendants.new(@native)
      else
        self
      end
    end
  # @!endgroup
  end
end