module ATSPI
  module SelectableCollection::Selected
    include Collection

    INDEX_METHOD = :index_in_parent

    def indices(limit: count)
      first(limit).map(&self.class::INDEX_METHOD)
    end

    def inspect
      indices = self.indices(limit: 5).inspect
      indices[-1] = ", …]" if count > 5
      "#<#{self.class.name}:0x#{'%x14' % __id__} @count=#{count} @indices=#{indices}>"
    end
  end
end