module ATSPI
  class Accessible::Descendants
    # @api private
    class AttributeFilter
      def initialize(mode: :any, attributes: {})
        @mode = mode
        @attributes = attributes
      end

      def extend(*attributes)
        attributes = attributes.to_h
        mode = attributes.delete(:mode) || @mode
        attributes = attributes.inject(@attributes) do |memo, (key, values)|
          memo.merge(key => [*memo[key], *values].uniq)
        end
        self.class.new(mode: mode, attributes: attributes)
      end

      def to_a
        attributes = @attributes.map do |key, values|
          escaped_values = values.map{ |value| value.gsub(':', '\:') }
          [key, escaped_values.join('::')]
        end.to_h
        [attributes, @mode]
      end

      def inspect
        "#{@mode}:#{@attributes.inspect}"
      end
    end
  end
end