module ATSPI
  module SelectableCollection
    include Collection

    def selected
      self.class::Selected.new(@native)
    end

    def select_all
      each(&:select)
    end

    def deselect_all
      selected.each(&:deselect)
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @selected=#{selected.inspect}>"
    end
  end
end