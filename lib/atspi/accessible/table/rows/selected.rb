module ATSPI
  class Accessible::Table
    class Rows::Selected
      include SelectableCollection::Selected

      INDEX_METHOD = :index

      def initialize(native)
        @native = native
      end

      def each
        @native.selected_rows.each do |idx|
          yield at(idx)
        end
      end

      def at(idx)
        Row.new(@native, idx)
      end

      def count
        @native.n_selected_rows
      end
    end
  end
end