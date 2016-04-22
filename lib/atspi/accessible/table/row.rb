class ATSPI::Accessible::Table
  class Row
    def initialize(native, index)
      @native = native
      @index = index
    end

    attr_reader :index
    
    def header
      header = @native.row_header(@index)
      Cell.new(header) if header
    end

    def description
      @native.row_description(@index)
    end

    def selected?
      @native.is_row_selected(@index)
    end

    def select
      @native.add_row_selection(@index)
    end

    def deselect
      @native.remove_row_selection(@index)
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @index=#{index} @selected?=#{selected?} " <<
        "@description=#{description.inspect}>"
    end
  end
end