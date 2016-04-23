Libatspi.load_class :Accessible

module ATSPI
  class Accessible
    extend Forwardable
    include Selectable
    include Component

    class << self
      def new(native)
        if self == Accessible
          native and (new_mapped(native) or super)
        else
          super
        end
      end

      def new_mapped(native)
        case native.role
        when :desktop_frame then Desktop.new(native)
        when :application then Application.new(native)
        when :frame then Window.new(native)
        else nil
        end
      end
    end

    def initialize(native)
      @native = native
    end

    attr_reader :native
    private :native

    delegate %i(name description) => :@native
    delegate %i(role role_name localized_role_name) => :@native
    delegate %i(toolkit_name toolkit_version) => :@native

    def parent
      Accessible.new(@native.get_parent)
    end

    delegate :index_in_parent => :@native
    alias_method :index, :index_in_parent

    def path
      parent.path + [*index_in_parent]
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
      Application.new(@native.application)
    end

    delegate :window => :parent
    delegate :desktop => :application

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
        []
      end
    end

    def document
      if @native.document_iface
        Document.new(@native)
      end
    end

    def text
      if @native.text_iface
        Text.new(@native)
      end
    end

    def hyperlink
      if hyperlink = @native.hyperlink
        Hyperlink.new(hyperlink)
      end
    end
    alias_method :link, :hyperlink

    def image
      if @native.image_iface
        Image.new(@native)
      end
    end

    def value
      if @native.value_iface
        Value.new(@native)
      end
    end

    def table
      if @native.table_iface
        Table.new(@native)
      end
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @desktop=#{desktop.index} " <<
        "@application=#{application.name} @window=#{window.name} @path=#{path.join('/')} " <<
        "@name=#{name.inspect} @role=#{role.inspect} @extents=#{extents(relative_to: :screen).inspect}>"
    end
  end
end
