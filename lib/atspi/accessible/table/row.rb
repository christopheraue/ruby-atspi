class ATSPI::Accessible::Table
  # Represents a row in a {Table}
  class Row
    # @api private
    def initialize(native, index)
      @native = native
      @index = index
    end

  # @group State & Attributes
    # @return [Integer] its index
    attr_reader :index

    # @return [Cell] its header
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-row-header atspi_table_get_row_header
    def header
      header = @native.row_header(@index)
      Cell.new(header) if header
    end

    # @return [String] its description
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-row-description atspi_table_get_row_description
    def description
      @native.row_description(@index)
    end

    # Checks if it is selected
    # @return [true,false]
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-is-row-selected atspi_table_is_row_selected
    def selected?
      @native.is_row_selected(@index)
    end
  # @endgroup

  # @group Actions
    # Selects its
    # @return [true,false]
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-add-row-selection atspi_table_add_row_selection
    def select
      @native.add_row_selection(@index)
    end

    # Deselects its
    # @return [true,false]
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-remove-row-selection atspi_table_remove_row_selection
    def deselect
      @native.remove_row_selection(@index)
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