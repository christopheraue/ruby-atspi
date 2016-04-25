module ATSPI
  class Accessible::Descendants
    # @api private
    class InterfaceFilter
      def initialize(mode: :all, interfaces: [])
        @mode = mode
        @interfaces = interfaces
      end

      def extend(*interfaces, mode: @mode)
        interfaces = @interfaces + interfaces.map(&:to_s)
        self.class.new(mode: mode, interfaces: interfaces.uniq)
      end

      def to_a
        [@interfaces.dup, @mode]
      end

      def inspect
        "#{@mode}:#{@interfaces.inspect}"
      end
    end
  end
end