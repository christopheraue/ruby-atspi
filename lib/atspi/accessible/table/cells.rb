class ATSPI::Accessible
  class Table
    # Represents all cells in a {Table}. Cells are also the children of their
    # {Table}.
    class Cells < Children
    # @!group Enumerable interface
      # @overload at(idx)
      #   @param (see Children#at)
      #
      # @overload at(row:, column:)
      #   @param (see #at_coords)
      #
      # @return [Cell] the cell at +idx+ or at (+row+,+column+)
      #
      # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-child-at-index atspi_accessible_get_child_at_index
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-accessible-at atspi_table_get_accessible_at
      def at(idx = nil)
        if idx.is_a? Numeric
          Cell.new(@native.child_at_index(idx))
        else
          at_coords(idx)
        end
      end

      # @param row [Integer]
      # @param colum [Integer]
      #
      # @return [Cell] the cell at (+row+,+column+)
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-accessible-at atspi_table_get_accessible_at
      def at_coords(row:, column:)
        Cell.new(@native.accessible_at(row, column))
      end
    # @!endgroup
    end
  end
end