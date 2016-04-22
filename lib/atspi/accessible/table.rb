module ATSPI
  class Accessible::Table
    def initialize(native)
      @native = native
    end

    def caption
      Accessible.new(@native.caption) if @native.caption
    end

    def summary
      Accessible.new(@native.summary) if @native.caption
    end

    def rows
      Rows.new(@native)
    end
    
    def columns
      Columns.new(@native)
    end

    def cells
      Cells.new(@native)
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @caption=#{caption.inspect} " <<
        "@cells=#{cells.inspect} @rows=#{rows.inspect} @columns=#{columns.inspect}>"
    end
  end
end