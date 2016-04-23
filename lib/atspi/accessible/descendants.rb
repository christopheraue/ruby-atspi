Libatspi.load_class :MatchRule

module ATSPI
  class Accessible::Descendants
    def initialize(native)
      @native = native
      @filters = {
        state: StateFilter.new,
        attribute: AttributeFilter.new,
        role: RoleFilter.new,
        interface: InterfaceFilter.new,
        name: NameFilter.new,
      }
      @options = Options.new(nil, inverted?: false, order: :canonical, limit: 25, recursive?: true)
    end

    def where(filters)
      dup(filters: @filters.map do |name, filter|
        extended_filter = filters[name] ? filter.extend(filters[name]) : filter
        [name, extended_filter]
      end.to_h)
    end

    def invert(invert = true)
      dup(options: @options.invert(invert))
    end

    def order_by(order)
      dup(options: @options.order_by(order))
    end

    def limit_to(limit)
      dup(options: @options.limit_to(limit))
    end

    def recursive(recursive = true)
      dup(options: @options.recursive(recursive))
    end

    def to_a
      match_rule = Libatspi::MatchRule.new(*@filters[:state], *@filters[:attribute],
        *@filters[:role], *@filters[:interface], @options.inverted?)
      matches = @native.matches(match_rule, *@options).to_a
      matches = matches.select{ |native| native.name =~ @filters[:name].match } if @filters[:name].match
      matches.map{ |native| Accessible.new(native) }
    end

    def method_missing(m, *args, &block)
      to_a.__send__(m, *args, &block)
    end

    def inspect
      filter_inspect = @filters.map{ |n,f| "@#{n}=#{f.inspect}" }.join(' ')
      "#<#{self.class.name}:0x#{'%x14' % __id__} #{filter_inspect} #{@options.inspect}>"
    end

    private

    def dup(values)
      clone = self.class.new(@native)
      instance_variables.each do |name|
        value = values[name.to_s.delete('@').to_sym] || instance_variable_get(name)
        clone.instance_variable_set(name, value)
      end
      clone
    end
  end
end