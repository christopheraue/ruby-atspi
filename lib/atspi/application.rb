module ATSPI
  # Applications are Accessibles having a few exceptions.
  class Application < Accessible
  # @!group Identification
    # It has no path.
    # @return [[]]
    def path
      []
    end

    # Its desktop is its parent
    # @return [Desktop]
    def desktop
      parent
    end

    # Its application is itself
    # @return [self]
    def application
      self
    end

    # It belongs to no window
    # @return nil
    def window
      nil
    end
  # @!endgroup

  # @!group Tree & Traversal
    # Its windows are its children.
    # @param (see Accessible#children)
    # @return (see Accessible#children)
    def windows
      children
    end

    # It cannot get descendants by path since the path begins not until
    # reaching the children of windows.
    # @return [nil]
    def descendant_by_path(*path)
      nil
    end
  # @!endgroup

  # @!group Representations
  # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @desktop=#{desktop.index} @name=#{name.inspect}>"
    end
  # @!endgroup
  end
end