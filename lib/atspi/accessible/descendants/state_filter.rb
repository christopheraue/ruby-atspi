module ATSPI
  class Accessible::Descendants
    # @api private
    class StateFilter
      def initialize(mode: :all, states: [])
        @mode = mode
        @states = states
      end

      def extend(*states, mode: @mode)
        self.class.new(mode: mode, states: (@states + states).uniq)
      end

      def to_a
        [StateSet.new(*@states).__send__(:native), @mode]
      end

      def inspect
        "#{@mode}:#{@states.inspect}"
      end
    end
  end
end