require 'forwardable'
require 'gir_ffi'

# I would like to name the Atspi module as Libatspi but there seems to be no
# easy way to namespace or rename modules imported by GirFFI. The Atspi name
# has to stay b/c it seems to be expected when loading other classes and
# calling methods. Therefore, Atspi is left as it is but is aliased as
# Libatspi to better differentiate it from our ATSPI namespace.
GirFFI.setup :Atspi
Libatspi = Atspi

require 'atspi/state_set'
require 'atspi/extents'
require 'atspi/accessible/selectable'
require 'atspi/accessible'
require 'atspi/accessible/action'
require 'atspi/accessible/children'
require 'atspi/accessible/descendants'
require 'atspi/accessible/descendants/filter'
require 'atspi/accessible/component'
require 'atspi/accessible/document'
require 'atspi/accessible/hyperlink'
require 'atspi/accessible/hyperlink/anchor'
require 'atspi/accessible/text/editable'
require 'atspi/accessible/text/hypertext'
require 'atspi/accessible/text'
require 'atspi/accessible/text/character'
require 'atspi/accessible/text/offset'
require 'atspi/accessible/text/caret'
require 'atspi/accessible/text/range'
require 'atspi/accessible/text/selection'
require 'atspi/accessible/text/hyperlink'
require 'atspi/accessible/image'
require 'atspi/accessible/value'

module ATSPI
  class << self
    def desktops
      @desktops ||= Libatspi.get_desktop_count.times.map do |idx|
        Accessible.new(Libatspi.get_desktop(idx))
      end
    end

    def applications(desktop = desktops.first)
      desktop.children
    end
  end

  class Error < StandardError; end
end