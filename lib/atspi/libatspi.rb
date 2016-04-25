require 'gir_ffi'

GirFFI.setup :Atspi

# Atspi is aliased as Libatspi to better differentiate it from our ATSPI
# namespace.
Libatspi = Atspi