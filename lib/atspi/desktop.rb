module ATSPI
  # Desktops are Accessibles having a few exceptions.
  class Desktop < Accessible
  # @!group Identification
    # It has no parent.
    # @return [nil]
    def parent
      nil
    end

    # It has no path.
    # @return [[]]
    def path
      []
    end

    # Its desktop is itself.
    # @return [self]
    def desktop
      self
    end

    # It belongs to no application.
    # @return nil
    def application
      nil
    end

    # It has no window.
    # @return nil
    def window
      nil
    end
  # @!endgroup

  # @!group Tree & Traversal
    # Its applications are its children.
    # @param (see Accessible#children)
    # @return (see Accessible#children)
    def applications
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
      "#<#{self.class.name}:0x#{'%x14' % __id__} @index=#{index} @name=#{name.inspect}>"
    end
  # @!endgroup
  end
end