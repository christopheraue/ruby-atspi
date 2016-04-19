Libatspi.load_class :Accessible

module ATSPI
  class Accessible
    extend Forwardable

    def initialize(native)
      @native = native
    end

    delegate %i(name description) => :@native
    delegate %i(role role_name localized_role_name) => :@native
    delegate %i(toolkit_name toolkit_version) => :@native

    def parent
      if %i(desktop_frame).include? role
        nil
      else
        Accessible.new(@native.get_parent)
      end
    end

    def index_in_parent
      case role
      when :desktop_frame then "desktop#{@native.index_in_parent}"
      when :application then name
      else @native.index_in_parent
      end
    end

    def path
      path = parent ? parent.path : []
      path + [*index_in_parent]
    end

    def children
      @native.child_count.times.map do |idx|
        Accessible.new(@native.child_at_index(idx))
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

    def application
      if application = @native.application
        Accessible.new(application)
      end
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @path=#{path.join('/')} @name=#{name.inspect} @role=#{role.inspect}>"
    end
  end
end
