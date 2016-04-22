Libatspi.load_class :Accessible

module ATSPI
  class Accessible
    extend Forwardable
    include Selectable

    def initialize(native)
      @native = native
    end

    attr_reader :native
    private :native

    delegate %i(name description) => :@native
    delegate %i(role role_name localized_role_name) => :@native
    delegate %i(toolkit_name toolkit_version) => :@native

    def parent
      case role
      when :desktop_frame then nil
      when :frame then application # open office frames have a nil parent
      else Accessible.new(@native.get_parent)
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
      Children.new(@native)
    end

    def relations
      @native.relation_set.to_a.inject({}) do |relations, relation|
        type = relation.relation_type
        targets = relation.n_targets.times.map{ |idx| Accessible.new(relation.target(idx)) }
        relations.merge!(type => targets)
      end
    end

    def states
      StateSet.new(@native.state_set)
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
      else
        nil
      end
    end

    def actions
      if @native.action_iface
        @native.n_actions.times.map{ |idx| Action.new(@native, idx) }
      else
        []
      end
    end

    def descendants
      if @native.collection_iface
        Descendants.new(@native)
      else
        nil
      end
    end
    alias_method :collection, :descendants

    def component
      if @native.component_iface
        Component.new(@native)
      else
        nil
      end
    end

    def document
      if @native.document_iface
        Document.new(@native)
      else
        nil
      end
    end

    def text
      if @native.text_iface
        Text.new(@native)
      else
        nil
      end
    end

    def hyperlink
      if hyperlink = @native.hyperlink
        Hyperlink.new(hyperlink)
      else
        nil
      end
    end
    alias_method :link, :hyperlink

    def image
      if @native.image_iface
        Image.new(@native)
      else
        nil
      end
    end

    def value
      if @native.value_iface
        Value.new(@native)
      else
        nil
      end
    end

    def table
      if @native.table_iface
        Table.new(@native)
      else
        nil
      end
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @path=#{path.join('/')} @name=#{name.inspect} @role=#{role.inspect}>"
    end
  end
end
