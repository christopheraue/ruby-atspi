module ATSPI
  class Accessible::Descendants
    class Filter
      def initialize(rule, values, valid_rules: %i(all any none empty))
        validate_rule(rule, valid_rules)
        @rule = rule
        @values = values
      end

      attr_reader :rule

      def values
        if @values.respond_to?(:native, true)
          @values.__send__(:native)
        else
          @values
        end
      end

      def to_a
        [values, rule]
      end

      def inspect
        if @values
          "#{@rule}:#{@values.inspect}"
        else
          @rule.inspect
        end
      end

      private

      def validate_rule(rule, valid_rules)
        unless valid_rules.include?(rule)
          raise Error, "rule needs to be one of #{valid_rules.map(&:inspect).join(', ')}"
        end
      end
    end
  end
end