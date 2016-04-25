class ATSPI::Accessible
  # Wraps libatspi's AtspiHyperlink[https://developer.gnome.org/libatspi/stable/AtspiHyperlink.html]
  # together with {Anchor}
  class Hyperlink
    extend Forwardable
    # @api private
    def initialize(native)
      @native = native
    end

    # @return [Array<Anchor>] its anchors
    # @see https://developer.gnome.org/libatspi/stable/AtspiHyperlink.html#atspi-hyperlink-get-n-anchors atspi_hyperlink_get_n_anchors
    def anchors
      @native.n_anchors.times.map do |idx|
        Anchor.new(@native, idx)
      end
    end

    # Checks if it's valid
    # @return [true,false]
    # @see https://developer.gnome.org/libatspi/stable/AtspiHyperlink.html#atspi-hyperlink-is-valid atspi_hyperlink_is_valid
    def valid?
      @native.is_valid
    end

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @anchors=#{anchors.inspect}>"
    end
  end
end