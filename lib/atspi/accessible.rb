Libatspi.load_class :Accessible

module ATSPI
  # Wraps libatspi's AtspiAccessible[https://developer.gnome.org/libatspi/stable/AtspiAccessible.html]
  #
  # The entry point to get ATSPI::Accessibles or one of it sub types are
  # {ATSPI.desktops ATSPI.desktops} and {ATSPI.applications ATSPI.applications}.
  # From there, accessibles are gotten via Tree & Traversal methods like
  # {#parent}, {#children} or {#descendants}.
  #
  # Most methods correspond directly to the method in libatspi. Some have an
  # extended or beautified interface that is documented here.
  class Accessible
    extend Forwardable
    include Extents
    include Selectable

    class << self
      # @api private
      def new(native)
        if self == Accessible
          native and (new_mapped(native) or super)
        else
          super
        end
      end

      private

      def new_mapped(native)
        case native.role
        when :desktop_frame then Desktop.new(native)
        when :application then Application.new(native)
        when :frame then Window.new(native)
        else nil
        end
      end
    end

    # @api private
    def initialize(native)
      @native = native
    end

    attr_reader :native
    private :native

  # @!group Identification
    # @return [Desktop] its desktop. That is the {#parent} of its {#application}.
    delegate :desktop => :application

    # @return [Application] its application
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-application atspi_accessible_get_application
    def application
      Application.new(@native.application)
    end

    # @return [Window] its top level window. It is a {#children child} of its {#application} and has
    #   the {#role} :frame.
    delegate :window => :parent

    # @return [Integer] the index in the collection of its {#parent} {#children}
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-index-in-parent atspi_accessible_get_index_in_parent
    delegate :index_in_parent => :@native
    alias_method :index, :index_in_parent

    # @return [Array<Integer>] the list of {#index_in_parent} of all its
    #   ancestors until reaching its {#window}, exclusive.
    def path
      parent.path + [*index_in_parent]
    end
  # @!endgroup

  # @!group Attributes & States
    # @return [String] its name
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-name atspi_accessible_get_name
    delegate :name => :@native

    # @return [String] its description
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-description atspi_accessible_get_description
    delegate :description => :@native

    # @return [Symbol] its role derived from libatspi's {AtspiRole enum}[https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiRole]
    #   by removing the prefix +ATSPI_ROLE_+ and making it lowercase.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-role atspi_accessible_get_role
    delegate :role => :@native

    # @return [String] its role as string
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-role-name atspi_accessible_get_role_name
    delegate :role_name => :@native

    # @return [String] its role as a localized string
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-localized-role-name atspi_accessible_get_localized_role_name
    delegate :localized_role_name => :@native

    # @return [String] its toolkit's name
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-toolkit-name atspi_accessible_get_toolkit_name
    delegate :toolkit_name => :@native

    # @return [String] its toolkit's version
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-toolkit-version atspi_accessible_get_toolkit_version
    delegate :toolkit_version => :@native

    # @return [StateSet] its states
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-state-set atspi_accessible_get_state_set
    def states
      StateSet.new_from_native(@native.state_set)
    end

    # @return [Hash<String => String>] its attributes
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-attributes atspi_accessible_get_attributes
    def attributes
      @native.attributes.to_h
    end

    # @return [Array<String>] the interfaces it implements
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-interfaces atspi_accessible_get_interfaces
    def interfaces
      @native.interfaces.to_a
    end
  # @!endgroup

  # @!group Tree & Traversal
    # @return [Accessible] its parent
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-parent atspi_accessible_get_parent
    def parent
      Accessible.new(@native.get_parent)
    end

    # @return [Children] its children
    def children
      Children.new(@native)
    end

    # @return [Descendants, []] its descendants. It will be an empty array it
    #   does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-collection collection interface}
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-collection atspi_accessible_get_collection
    def descendants
      if @native.collection_iface
        Descendants.new(@native)
      else
        []
      end
    end

    # @return [Accessible] its descendant found at the given path
    #
    # @overload descendant_by_path(path)
    #   @param path [Array] a path as returned by {#path}
    #
    #   @example
    #     descendant        # => #<ATSPI::Accessible:0xc1f18814 … @path=0/0/2/1 … >
    #     descendant.path   # => [0, 0, 2, 1]
    #     accessible.descendant_by_path(descendant.path) # => #<ATSPI::Accessible:0xc1f18814 … @path=0/0/2/1 … >
    #
    # @overload descendant_by_path(child_idx, grand_child_idx, *further_indices)
    #   @param child_idx [Integer] the child's {#index_in_parent}
    #   @param grand_child_idx [Integer] the grand child's {#index_in_parent}
    #   @param further_indices [Integer] additional {#index_in_parent}s of further descendants
    #
    #   @example
    #     accessible.descendant_by_path(0, 0, 2, 1) # => #<ATSPI::Accessible:0xc1f18814 … @path=0/0/2/1 … >
    def descendant_by_path(*path)
      path = path.flatten
      child = children[path.shift]
      found = child.nil? || path.empty?
      found ? child : child.descendant_by_path(path)
    end

    # @return [Hash<Symbol => Array<Accessible>>] its relations to other
    #   accessibles. Keys name the relation type and values are relation
    #   targets.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-relation-set atspi_accessible_get_relation_set
    # @see https://developer.gnome.org/libatspi/stable/AtspiRelation.html atspi-relation
    def relations
      @native.relation_set.to_a.inject({}) do |relations, relation|
        type = relation.relation_type
        targets = relation.n_targets.times.map{ |idx| Accessible.new(relation.target(idx)) }
        relations.merge!(type => targets)
      end
    end
  # @!endgroup

  # @!group Actions
    # @return [Array<Action>] the actions it supports. The array will be empty
    #   if it does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-action action interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-action atspi_accessible_get_action_iface
    def actions
      if @native.action_iface
        @native.n_actions.times.map{ |idx| Action.new(@native, idx) }
      else
        []
      end
    end
  # @!endgroup

  # @!group Representative for
    # @return [Document, nil] its document. It will be nil if it does not
    #   implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-document document interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-document atspi_accessible_get_document_iface
    def document
      if @native.document_iface
        Document.new(@native)
      end
    end

    # @return [Text, nil] its text. It will be nil if it does not
    #   implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-text text interface}.
    #
    # @note The {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-editable-text editable_text interface}
    #   and {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-hypertext hypertext interface} are
    #   available through {Text}, too.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-text atspi_accessible_get_text_iface
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-editable-text atspi_accessible_get_editable_text_iface
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-hypertext atspi_accessible_get_hypertext_iface
    def text
      if @native.text_iface
        Text.new(@native)
      end
    end

    # @return [Hyperlink, nil] its hyperlink. It will be nil if it does not
    #   have a {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-hyperlink hyperlink}.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-hyperlink atspi_accessible_get_hyperlink
    def hyperlink
      if hyperlink = @native.hyperlink
        Hyperlink.new(hyperlink)
      end
    end
    alias_method :link, :hyperlink

    # @return [Image, nil] its image. It will be nil if it does not
    #   implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-image image interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-image atspi_accessible_get_image_iface
    def image
      if @native.image_iface
        Image.new(@native)
      end
    end

    # @return [Value, nil] its image. It will be nil if it does not
    #   implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-value value interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-value atspi_accessible_get_value_iface
    def value
      if @native.value_iface
        Value.new(@native)
      end
    end

    # @return [Table, nil] its table. It will be nil if it does not
    #   implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-table table interface}.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-table atspi_accessible_get_table_iface
    def table
      if @native.table_iface
        Table.new(@native)
      end
    end
  # @!endgroup

  # @!group Representations
    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @desktop=#{desktop.index} " <<
        "@application=#{application.name} @window=#{window.name} @path=#{path.join('/')} " <<
        "@name=#{name.inspect} @role=#{role.inspect} @extents=#{extents(relative_to: :screen).inspect}>"
    end
  # @!endgroup
  end
end
