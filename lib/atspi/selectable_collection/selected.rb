module ATSPI
  # Included in classes representing the selected subset of a selectable collection
  module SelectableCollection::Selected
    include Collection

    # @api private
    INDEX_METHOD = :index_in_parent

    def indices(limit: count)
      [*first(limit)].map(&self.class::INDEX_METHOD)
    end
    private :indices

  # @!group Representation
    # @return [String] instance as inspectable string
    def inspect
      indices = self.__send__(:indices, limit: 5).inspect
      indices[-1] = ", …]" if count > 5
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @indices=#{indices}>"
    end
  # @!endgroup
  end
end