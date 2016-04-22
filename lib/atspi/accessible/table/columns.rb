module ATSPI
  class Accessible::Table
    class Columns
      include SelectableCollection

      INDEX_METHOD = :index

      def initialize(native)
        @native = native
      end

      def at(*)
        super do |idx|
          Column.new(@native, idx)
        end
      end

      def count
        @native.n_columns
      end
    end
  end
end