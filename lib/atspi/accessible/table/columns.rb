module ATSPI
  class Accessible::Table
    # Represents all columns in a {Table}
    class Columns
      include SelectableCollection

      # @api private
      INDEX_METHOD = :index

      # @api private
      def initialize(native)
        @native = native
      end

    # @!group Enumerable interface
      # @param idx [Integer]
      #
      # @return [Column] the column at index +idx+
      def at(idx)
        super do |mapped_idx|
          Column.new(@native, mapped_idx)
        end
      end

      # @return [Integer] its number of columns
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-n-columns atspi_table_get_n_columns
      def count
        @native.n_columns
      end
    # @!endgroup
    end
  end
end