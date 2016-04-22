module ATSPI
  class Accessible::Table
    class Rows
      include SelectableCollection

      def initialize(native)
        @native = native
      end

      def at(idx)
        Row.new(@native, idx)
      end

      def count
        @native.n_rows
      end
    end
  end
end