class ATSPI::Accessible
  module Selectable
    def selectable?
      parent.children.selectable?
    end

    def select
      selectable? and parent.__send__(:native).select_child(index_in_parent)
    end

    def deselect
      selectable? and parent.__send__(:native).deselect_child(index_in_parent)
    end

    def selected?
      selectable? and parent.__send__(:native).is_child_selected(index_in_parent)
    end
  end
end