module ATSPI
  class Accessible::Table
    class Columns::Selected
      include SelectableCollection::Selected

      INDEX_METHOD = :index

      def initialize(native)
        @native = native
      end

      def each
        @native.selected_columns.each do |idx|
          yield at(idx)
        end
      end

      def at(*)
        super do |idx|
          Column.new(@native, idx)
        end
      end

      def count
        @native.n_selected_columns
      end
    end
  end
end