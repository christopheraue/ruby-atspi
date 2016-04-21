module ATSPI
  class Accessible::Value
    extend Forwardable

    def initialize(native)
      @native = native
    end

    delegate %i(minimum_value maximum_value current_value) => :@native
    delegate :set_current_value => :@native
    delegate :minimum_increment => :@native

    alias_method :minimum, :minimum_value
    alias_method :min, :minimum_value

    alias_method :maximum, :maximum_value
    alias_method :max, :maximum_value

    alias_method :current, :current_value
    alias_method :cur, :current_value
    alias_method :to_i, :current_value

    alias_method :increment, :minimum_increment
    alias_method :incr, :minimum_increment
    alias_method :step, :minimum_increment

    alias_method :set_to, :set_current_value

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @min=#{min} @cur=#{cur} @max=#{max} @incr=#{incr}>"
    end
  end
end