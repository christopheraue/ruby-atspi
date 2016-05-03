module ATSPI
  class Accessible::Table
    # Represents all selected rows of a {Table}.
    #
    # Instance are enumerables supporting item access and can be treated more or
    # less like an array.
    class Rows::Selected
      include SelectableCollection::Selected

      # @api private
      INDEX_METHOD = :index

      # @api private
      def initialize(native)
        @native = native
      end

    # @!group Enumerable interface
      # Iterates over all selected rows
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-selected-rows atspi_table_get_selected_rows
      def each
        @native.selected_rows.each do |idx|
          yield at(idx)
        end
      end

      # @param n [Integer] the index in the collection of selected rows and
      #   not the index in the collection of all the table's rows.
      #
      # @return [Row] the table's n'th selected row
      def at(n)
        super do |idx|
          Row.new(@native, idx)
        end
      end

      # @return [Integer] the number of selected rows
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-n-selected-rows atspi_table_get_n_selected_rows
      def count
        @native.n_selected_rows
      end
    # @!endgroup
    end
  end
end