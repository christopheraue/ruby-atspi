Libatspi.load_class :StateSet

module ATSPI
  class StateSet
    extend Forwardable

    def self.new_from_states(states)
      new(Libatspi::StateSet.new(states))
    end

    def initialize(native)
      @native = native
    end

    attr_reader :native
    private :native

    delegate %i(add remove) => :@native
    delegate %i(contains is_empty) => :@native
    delegate %i(states) => :@native
    delegate %i(to_a) => :states

    alias_method :contains?, :contains
    alias_method :empty?, :is_empty

    def set_by_name(name, active)
      @native.set_by_name(name.to_s, !!active)
    end

    def compare(state_set)
      StateSet.new @native.compare(state_set.__send__(:native))
    end
    alias_method :difference, :compare
    alias_method :^, :compare

    def equals(state_set)
      @native.equals state_set.__send__(:native)
    end
    alias_method :equals?, :equals
    alias_method :==, :equals

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @states=#{to_a.inspect}>"
    end
  end
end