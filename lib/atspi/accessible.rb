Libatspi.load_class :Accessible

module ATSPI
  class Accessible
    extend Forwardable

    def initialize(native, opts = {})
      @native = native
      @parent = opts[:parent] if opts.has_key? :parent
      @index_in_parent = opts[:index] if opts.has_key? :index
    end

    delegate %i(name description) => :@native
    delegate %i(role role_name localized_role_name) => :@native
    delegate %i(toolkit_name toolkit_version) => :@native

    def parent
      if instance_variable_defined? :@parent # so we can set parent to nil on initialization
        @parent
      else
        @parent = Accessible.new(@native.parent)
      end
    end

    def index_in_parent
      @index_in_parent ||= @native.index_in_parent
    end

    def path
      @path ||= if parent
        parent.path + [index_in_parent]
      else
        [index_in_parent]
      end
    end

    def children
      @native.child_count.times.map do |idx|
        Accessible.new(@native.child_at_index(idx), parent: self, index: idx)
      end
    end

    def relations
      @native.relation_set.to_a.inject({}) do |relations, relation|
        type = relation.relation_type
        targets = relation.n_targets.times.map{ |idx| Accessible.new(relation.target(idx)) }
        relations.merge!(type => targets)
      end
    end

    def states
      @native.state_set.states.to_a
    end

    def attributes
      @native.attributes.to_h
    end

    def interfaces
      @native.interfaces.to_a
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @path=#{path.join('/')} @name=#{name.inspect} @role=#{role.inspect}>"
    end
  end
end
