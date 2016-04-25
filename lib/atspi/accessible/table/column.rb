class ATSPI::Accessible::Table
  # Represents a column in a {Table}
  class Column
    # @!visibility private
    def initialize(native, index)
      @native = native
      @index = index
    end
    # @!visibility public

  # @group State & Attributes
    # @return [Integer] its index
    attr_reader :index

    # @return [Cell] its header
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-column-header atspi_table_get_column_header
    def header
      header = @native.column_header(@index)
      Cell.new(header) if header
    end

    # @return [String] its description
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-column-description atspi_table_get_column_description
    def description
      @native.column_description(@index)
    end

    # Checks if it is selected
    # @return [true,false]
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-is-column-selected atspi_table_is_column_selected
    def selected?
      @native.is_column_selected(@index)
    end
  # @endgroup

  # @group Actions
    # Selects its
    # @return [true,false]
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-add-column-selection atspi_table_add_column_selection
    def select
      @native.add_column_selection(@index)
    end

    # Deselects its
    # @return [true,false]
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-remove-column-selection atspi_table_remove_column_selection
    def deselect
      @native.remove_column_selection(@index)
    end
  # @endgroup

  # @group Representations
    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @index=#{index} @selected?=#{selected?} " <<
        "@description=#{description.inspect}>"
    end
  # @endgroup
  end
end