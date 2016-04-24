module ATSPI
  module SelectableCollection::Selected
    include Collection

  # @!visibility private
    INDEX_METHOD = :index_in_parent

    def indices(limit: count)
      [*first(limit)].map(&self.class::INDEX_METHOD)
    end
    private :indices
  # @!visibility public

  # @!group Representation
    # @return [String] instance as inspectable string
    def inspect
      indices = self.indices(limit: 5).inspect
      indices[-1] = ", …]" if count > 5
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @indices=#{indices}>"
    end
  # @!endgroup
  end
end