require 'gir_ffi'

# I would like to name the Atspi module as Libatspi but there seems to be no
# easy way to namespace or rename modules imported by gir ffi. The Atspi name
# has to stay b/c it seems to be expected when loading other classes and
# calling methods. Therefore, Atspi are left as it is but is aliased as
# Libatspi to better differentiate it from our ATSPI namespace
GirFFI.setup :Atspi
Libatspi = Atspi

require 'atspi/accessible'

module ATSPI

end
