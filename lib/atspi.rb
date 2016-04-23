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
require 'atspi/collection'
require 'atspi/selectable_collection'
require 'atspi/selectable_collection/selected'
require 'atspi/accessible/selectable'
require 'atspi/accessible/component'
require 'atspi/accessible'
require 'atspi/accessible/action'
require 'atspi/accessible/children'
require 'atspi/accessible/children/selected'
require 'atspi/accessible/descendants'
require 'atspi/accessible/descendants/state_filter'
require 'atspi/accessible/descendants/attribute_filter'
require 'atspi/accessible/descendants/role_filter'
require 'atspi/accessible/descendants/interface_filter'
require 'atspi/accessible/descendants/name_filter'
require 'atspi/accessible/descendants/options'
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
require 'atspi/accessible/table'
require 'atspi/accessible/table/columns'
require 'atspi/accessible/table/columns/selected'
require 'atspi/accessible/table/column'
require 'atspi/accessible/table/rows'
require 'atspi/accessible/table/rows/selected'
require 'atspi/accessible/table/row'
require 'atspi/accessible/table/cells'
require 'atspi/accessible/table/cell'
require 'atspi/accessible/table/cell/rows'
require 'atspi/accessible/table/cell/columns'
require 'atspi/accessible/image'
require 'atspi/accessible/value'
require 'atspi/desktop'
require 'atspi/application'
require 'atspi/window'

module ATSPI
  class << self
    def desktops
      @desktops ||= Libatspi.get_desktop_count.times.map do |idx|
        Desktop.new(Libatspi.get_desktop(idx))
      end
    end

    def applications(desktop = desktops.first)
      desktop.applications
    end
  end

  class Error < StandardError; end
end