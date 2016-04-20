require 'forwardable'
require 'gir_ffi'

# I would like to name the Atspi module as Libatspi but there seems to be no
# easy way to namespace or rename modules imported by gir ffi. The Atspi name
# has to stay b/c it seems to be expected when loading other classes and
# calling methods. Therefore, Atspi are left as it is but is aliased as
# Libatspi to better differentiate it from our ATSPI namespace
GirFFI.setup :Atspi
Libatspi = Atspi

require 'atspi/accessible'
require 'atspi/accessible/action'
require 'atspi/accessible/component'
require 'atspi/accessible/component/point'
require 'atspi/accessible/component/rect'
require 'atspi/accessible/document'
require 'atspi/state_set'

module ATSPI
  class << self
    def desktops
      @desktops ||= Libatspi.get_desktop_count.times.map do |idx|
        Accessible.new(Libatspi.get_desktop(idx))
      end
    end
  end
end