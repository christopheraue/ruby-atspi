module ATSPI
  class Accessible::Table
    class Cell < Accessible
      def rows
        Rows.new(@native)
      end

      def columns
        Columns.new(@native)
      end
    end
  end
end