module ATSPI
  class Accessible::Table
    # Represents the columns a table {Cell} spans.
    class Cell::Columns
      include SelectableCollection::Selected

      # @!visibility private
      INDEX_METHOD = :index

      # @!visibility private
      def initialize(native)
        @native = native
        @first_idx = row_col_span[2]
      end
      # @!visibility public

    # @!group Enumerable interface
      # @param n [Integer] the index in the collection of the cell's columns
      #   and not the index in the collection of all the table's columns.
      #
      # @return [Column] the n'th column of the cell
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-row-column-extents-at-index atspi_table_get_row_column_extents_at_index
      def at(n)
        super do |mapped_idx|
          Column.new(@native.get_parent, @first_idx+mapped_idx)
        end
      end

      # @return [Integer] the number of columns the cell spans
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-row-column-extents-at-index atspi_table_get_row_column_extents_at_index
      def count
        row_col_span[4]
      end
    # @!endgroup

      private

      def row_col_span
        @native.get_parent.row_column_extents_at_index(@native.index_in_parent)
      end
    end
  end
end