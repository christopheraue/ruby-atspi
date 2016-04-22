module ATSPI
  class Accessible::Children
    include SelectableCollection

    def initialize(native)
      @native = native
    end

    def at(idx)
      Accessible.new(@native.child_at_index(idx))
    end

    def count
      @native.child_count
    end

    def selectable?
      not @native.selection_iface.nil?
    end

    def selected
      if selectable?
        Selected.new(@native)
      else
        []
      end
    end

    def select_all
      selectable? and @native.select_all
    end

    def deselect_all
      selectable? and @native.clear_selection
    end
  end
end