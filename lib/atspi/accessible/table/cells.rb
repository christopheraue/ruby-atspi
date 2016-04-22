class ATSPI::Accessible
  class Table
    class Cells < Children
      def at(idx = nil)
        if idx.is_a? Numeric
          Cell.new(@native.child_at_index(idx))
        else
          at_coords(idx)
        end
      end

      def at_coords(row:, column:)
        Cell.new(@native.accessible_at(row, column))
      end
    end
  end
end