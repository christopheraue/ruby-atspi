module ATSPI
  class Accessible::Table
    # Represents all rows in a {Table}.
    #
    # Instance are enumerables supporting item access and can be treated more or
    # less like an array.
    class Rows
      include SelectableCollection

      # @api private
      def initialize(native)
        @native = native
      end

    # @!group Enumerable interface
      # @param idx [Integer]
      #
      # @return [Row] the row at index +idx+
      def at(idx)
        super do |mapped_idx|
          Row.new(@native, mapped_idx)
        end
      end

      # @return [Integer] its number of rows
      #
      # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-table.html#atspi-table-get-n-rows atspi_table_get_n_rows
      def count
        @native.n_rows
      end
    # @!endgroup
    end
  end
end