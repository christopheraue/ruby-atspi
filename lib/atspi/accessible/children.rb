module ATSPI
  class Accessible::Children < Array
    def initialize(native, children)
      @native = native
      super(children)
    end

    def selectable?
      not @native.selection_iface.nil?
    end

    def selected
      selected_children_count = selectable? ? @native.n_selected_children : 0
      selected_children_count.times.map{ |idx| Accessible.new(@native.selected_child(idx)) }
    end

    def select_all
      selectable? and @native.select_all
    end

    def clear_selection
      selectable? and @native.clear_selection
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @selectable?=#{selectable?} " <<
        "@selected=#{selected.map(&:index_in_parent).inspect}>"
    end
  end
end