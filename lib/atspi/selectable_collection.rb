module ATSPI
  module SelectableCollection
    include Collection

  # @!group Selection
    def selected
      self.class::Selected.new(@native)
    end

    def select_all
      each(&:select)
    end

    def deselect_all
      selected.each(&:deselect)
    end
  # @!endgroup

  # @!group Representation
    # @return [String] instance as inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @selected=#{selected.inspect}>"
    end
  # @!endgroup
  end
end