# FFI
require 'atspi/libatspi'

require 'forwardable'

# General
require 'atspi/state_set'
require 'atspi/extents'

# Collection modules
require 'atspi/collection'
require 'atspi/selectable_collection'
require 'atspi/selectable_collection/selected'

# Accessible
require 'atspi/accessible/selectable'
require 'atspi/accessible/extents'
require 'atspi/accessible'

# Action
require 'atspi/accessible/action'

# Children
require 'atspi/accessible/children'

# Descendants
require 'atspi/accessible/descendants'
require 'atspi/accessible/descendants/state_filter'
require 'atspi/accessible/descendants/attribute_filter'
require 'atspi/accessible/descendants/role_filter'
require 'atspi/accessible/descendants/interface_filter'
require 'atspi/accessible/descendants/name_filter'
require 'atspi/accessible/descendants/options'

# Document
require 'atspi/accessible/document'

# Hyperlink
require 'atspi/accessible/hyperlink'
require 'atspi/accessible/hyperlink/anchor'

# Text
require 'atspi/accessible/text/editable'
require 'atspi/accessible/text/hypertext'
require 'atspi/accessible/text'
require 'atspi/accessible/text/character'
require 'atspi/accessible/text/offset'
require 'atspi/accessible/text/caret'
require 'atspi/accessible/text/range'
require 'atspi/accessible/text/selection'
require 'atspi/accessible/text/hyperlink'

# Table
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

# Image
require 'atspi/accessible/image'

# Value
require 'atspi/accessible/value'

# Specific accessibles
require 'atspi/desktop'
require 'atspi/application'
require 'atspi/window'
require 'atspi/error_accessible'