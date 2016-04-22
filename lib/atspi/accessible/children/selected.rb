module ATSPI
  class Accessible::Children::Selected
    include SelectableCollection::Selected

    def initialize(native)
      @native = native
    end

    def at(*)
      super do |idx|
        Accessible.new(@native.selected_child(idx))
      end
    end

    def count
      @native.n_selected_children
    end
  end
end