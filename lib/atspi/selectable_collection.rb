module ATSPI
  # Included in classes representing a collection having selectable items.
  #
  # Instance are enumerables supporting item access and can be treated more or
  # less like an array.
  module SelectableCollection
    include Collection

  # @!group Selection
    # @return [Selected] its selected subset
    def selected
      self.class::Selected.new(@native)
    end

    # Selects all items
    # @return [true,false] indicating success
    def select_all
      map(&:select).all?
    end

    # Deselects all items
    # @return [true,false] indicating success
    def deselect_all
      selected.map(&:deselect).all?
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