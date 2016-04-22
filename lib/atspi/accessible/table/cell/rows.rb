module ATSPI
  class Accessible::Table
    class Cell::Rows
      include SelectableCollection::Selected

      INDEX_METHOD = :index

      def initialize(native)
        @native = native
        @first_idx = row_col_span[1]
      end

      def at(idx)
        Row.new(@native.get_parent, @first_idx+idx)
      end

      def count
        row_col_span[3]
      end

      private

      def row_col_span
        @native.get_parent.row_column_extents_at_index(@native.index_in_parent)
      end
    end
  end
end