module ATSPI
  # Wraps libatspi's AtspiTable[https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html].
  class Accessible::Table
    # @!visibility private
    def initialize(native)
      @native = native
    end
    # @!visibility public

  # @group Attributes
    # @return [Accessible,nil] its caption
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-caption atspi_table_get_caption
    def caption
      Accessible.new(@native.caption) if @native.caption
    end

    # @return [Accessible,nil] its summary
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-summary atspi_table_get_summary
    def summary
      Accessible.new(@native.summary) if @native.caption
    end
  # @endgroup

  # @group Parts
    # @return [Rows] its rows
    def rows
      Rows.new(@native)
    end

    # @return [Columns] its columns
    def columns
      Columns.new(@native)
    end

    # @return [Cells] its cells
    def cells
      Cells.new(@native)
    end
  # @endgroup

  # @group Representations
    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @caption=#{caption.inspect} " <<
        "@cells=#{cells.inspect} @rows=#{rows.inspect} @columns=#{columns.inspect}>"
    end
  # @endgroup
  end
end