module ATSPI
  class Accessible::Table
    # Represents all selected columns of a {Table}
    class Columns::Selected
      include SelectableCollection::Selected

      # @api private
      INDEX_METHOD = :index

      # @api private
      def initialize(native)
        @native = native
      end

    # @!group Enumerable interface
      # Iterates over all selected columns
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-selected-columns atspi_table_get_selected_columns
      def each
        @native.selected_columns.each do |idx|
          yield at(idx)
        end
      end

      # @param n [Integer] the index in the collection of selected columns and
      #   not the index in the collection of all the table's columns.
      #
      # @return [Column] the table's n'th selected column
      def at(n)
        super do |mapped_idx|
          Column.new(@native, mapped_idx)
        end
      end

      # @return [Integer] the number of selected columns
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-n-selected-columns atspi_table_get_n_selected_columns
      def count
        @native.n_selected_columns
      end
    # @!endgroup
    end
  end
end