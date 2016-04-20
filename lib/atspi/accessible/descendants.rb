Libatspi.load_class :MatchRule

module ATSPI
  class Accessible::Descendants
    extend Forwardable
    include Enumerable

    def initialize(native)
      @native = native
      where_any_states
      where_any_attributes
      where_any_role
      where_any_interfaces
      invert(false)
      order_by(:canonical)
      limit_to(0)
      recursive(true)
    end

    def where_states(*states, rule: :all)
      states = StateSet.new_from_states(states)
      @states = Filter.new(rule, states)
      self
    end

    def where_any_states
      where_states(rule: :all)
    end
    alias_method :reset_states, :where_any_states

    def where_attributes(attributes)
      rule = attributes.delete(:rule) || :any
      @attributes = Filter.new(rule, attributes)
      self
    end

    def where_any_attributes
      where_attributes(rule: :all)
    end
    alias_method :reset_attributes, :where_any_attributes

    def where_role(*roles, rule: :any)
      @roles = Filter.new(rule, roles)
      self
    end

    def where_any_role
      where_role(rule: :any)
    end
    alias_method :reset_role, :where_any_role

    def where_interfaces(*interfaces, rule: :all)
      @interfaces = Filter.new(rule, interfaces.map(&:to_s))
      self
    end

    def where_any_interfaces
      where_interfaces(rule: :all)
    end
    alias_method :reset_interfaces, :where_any_interfaces

    def invert(invert = true)
      @invert = invert
      self
    end

    def order_by(order)
      @order = order
      self
    end

    def limit_to(limit)
      @limit = limit
      self
    end

    def recursive(recursive)
      @recursive = recursive
      self
    end

    def stop_at(accessible, traverse_by: :inorder, siblings_only: false)
      @stop_at = accessible
      @traversal_restriction = traverse_by
      @siblings_only = siblings_only
      self
    end

    def start_at(accessible, traverse_by: :inorder)
      @start_at = accessible
      @traversal_restriction = traverse_by
      self
    end

    def each
      match_rule = Libatspi::MatchRule.new(*@states, *@attributes, *@roles, *@interfaces, @invert)
      if @start_at
        @native.matches_from(@start_at.__send__(:native), match_rule, @order,
          @traversal_restriction, @limit, @recursive)
      elsif @stop_at
        @native.matches_to(@stop_at.__send__(:native), match_rule, @order,
          @traversal_restriction, @siblings_only, @limit, @recursive)
      else
        @native.matches(match_rule, @order, @limit, @recursive)
      end.each do |acc|
        yield Accessible.new(acc)
      end
    end

    delegate :[] => :to_a

    def inspect
      inst_vars = instance_variables.map do |name|
        next if name == :@native
        "#{name}=#{instance_variable_get(name).inspect}"
      end.compact
      "#<#{self.class.name}:0x#{'%x14' % __id__} #{inst_vars.join(' ')}>"
    end
  end
end