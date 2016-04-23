require 'gir_ffi'

# Atspi is aliased as Libatspi to better differentiate it from our ATSPI
# namespace.
GirFFI.setup :Atspi
Libatspi = Atspi