class ATSPI::Accessible::Text
  # Wraps libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-hypertext.html#AtspiHypertext hypertext interface}.
  module Hypertext
  # @!group Attributes & States
    # Checks if it is a hypertext.
    #
    # @return [true,false]
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-hypertext atspi_accessible_get_hypertext_iface
    def hypertext?
      not @native.hypertext_iface.nil?
    end

    # @return [Array<Hyperlink>] its hyperlinks. Will be an empty array if it
    #   is not a hypertext.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-hypertext.html#atspi-hypertext-get-n-links atspi_hypertext_get_n_links
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-hypertext.html#atspi-hypertext-get-link atspi_hypertext_get_link
    def hyperlinks
      if hypertext?
        @native.n_links.times.map{ |idx| Hyperlink.new(@native, @native.link(idx)) }
      else
        []
      end
    end
    alias_method :links, :hyperlinks
  # @!endgroup
  end
end