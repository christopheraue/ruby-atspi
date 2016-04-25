module ATSPI
  class Accessible::Table
    # Represents a cell in a {Table}. It is child accessible of its {Table}.
    class Cell < Accessible
      # @return [Rows] the rows it spans
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-row-column-extents-at-index atspi_table_get_row_column_extents_at_index
      def rows
        Rows.new(@native)
      end

      # @return [Columns] the columns it spans
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-row-column-extents-at-index atspi_table_get_row_column_extents_at_index
      def columns
        Columns.new(@native)
      end
    end
  end
end