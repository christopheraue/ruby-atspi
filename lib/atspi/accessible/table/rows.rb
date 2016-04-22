module ATSPI
  class Accessible::Table
    class Rows
      include SelectableCollection

      def initialize(native)
        @native = native
      end

      def at(*)
        super do |idx|
          Row.new(@native, idx)
        end
      end

      def count
        @native.n_rows
      end
    end
  end
end