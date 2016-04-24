module ATSPI
  # Windows are Accessibles having a few exceptions.
  class Window < Accessible
  # @!group Identification
    # It has no path.
    # @return [[]]
    def path
      []
    end

    # Its parent is its application
    # @return [Application]
    def parent
      application
    end

    # Its window is itself
    # @return [self]
    def window
      self
    end
  # @!endgroup

  # @!group Representations
  # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @desktop=#{desktop.index} " <<
        "@application=#{application.name} @name=#{name.inspect} " <<
        "@extents=#{extents(relative_to: :screen).inspect}>"
    end
  # @!endgroup
  end
end