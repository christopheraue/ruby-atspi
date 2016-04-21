class ATSPI::Accessible::Text
  module Hypertext
    def hypertext?
      not @native.hypertext_iface.nil?
    end

    def hyperlinks
      if hypertext?
        @native.n_links.times.map{ |idx| Hyperlink.new(@native, @native.link(idx)) }
      else
        []
      end
    end
    alias_method :links, :hyperlinks
  end
end