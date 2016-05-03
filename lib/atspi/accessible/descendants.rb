Libatspi.load_class :MatchRule

module ATSPI
  # A collection of all descendants in the tree below the accessible it belongs
  # to. It can be filtered by state, attribute, role, interface and name using
  # {#where}. The number of descendants to return can be set by {#limit_to}.
  # Recursive search of the tree can be turned on and off by {#recursive}.
  #
  # All methods can be chained together:
  #
  #   descendants = ATSPI.applications.first.descendants
  #   descendants.where(role: :page_tab, state: :selected).recursive(false).limit_to(1)
  #   # => #<ATSPI::Accessible::Descendants:0x101c51014 @state=all:[:selected] @role=any:[:page_tab] @limit=1 @recursive?=false … >
  #
  # To get the actual collection as an array call {#to_a}. Methods not defined
  # here are automatically delegated to {#to_a}, so instances of this class can
  # be directly treated like an array.
  #
  #   descendants.where(interface: :Action).map{ |d| d.actions.map(&:name) }
  #   # => [["click"], [], ["click"], [], …]
  #
  # In essence, it wraps libatspi's AtspiCollection[https://developer.gnome.org/libatspi/stable/libatspi-atspi-collection.html] and
  # AtspiMatchRule[https://developer.gnome.org/libatspi/stable/AtspiMatchRule.html]
  class Accessible::Descendants
    extend Forwardable
    # Delegate all methods of arrays directly to the array representation so
    # methods available otherwise (like #select through Kernel) do not
    # interfere
    Array.instance_methods(false).each do |method|
      delegate method => :to_a
    end

    # @api private
    def initialize(native)
      @native = native
      @filters = {
        state: StateFilter.new,
        attributes: AttributeFilter.new,
        role: RoleFilter.new,
        interface: InterfaceFilter.new,
        name: NameFilter.new,
      }
      @options = Options.new(nil, inverted?: false, order: :canonical, limit: 0, recursive?: true)
    end

  # @!group Filter
    # @note Filtering sometimes felt rocky on libatspi's side during testing.
    #   See the notes in the following sections for details.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiMatchRule.html#atspi-match-rule-new atspi_match_rule_new
    #
    # @return [Descendants] a copy of this instance with the modified filters.
    #
    # @overload where(state:)
    #   Filters by state(s)
    #
    #   @param state [Symbol,Array<Symbol[, mode: :all]>] the states filter.
    #     States are given as symbol derived from libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiStateType AtspiStateType enum}
    #     by removing the +ATSPI_STATE_+ prefix and making it lowercase.
    #
    #     When given an array, the last item can be set to a hash configuring
    #     the filter mode. The mode has to be one of +:all+, +:any+, +:none+,
    #     +:empty+. It corresponds to the match type in {https://developer.gnome.org/libatspi/stable/AtspiMatchRule.html#atspi-match-rule-new atspi_match_rule_new} and
    #     {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCollectionMatchType AtspiCollectionMatchType}, accordingly.
    #
    #   @example
    #     # Selects accessibles in state :selected
    #     where(state: :selected)
    #
    #     # Selects accessibles in both states :selectable *and* :selected
    #     where(state: [:selectable, :selected])
    #
    #     # Selects accessibles in either state :selectable *or* :selected (or both)
    #     where(state: [:selectable, :selected, mode: :any])
    #
    # @overload where(attributes:)
    #   Filters by attribute(s)
    #
    #   @param attributes [Hash<String => String[, mode: :any]>] the attributes
    #     filter. Attributes are given as a Hash as returned by
    #     {Accessible#attributes}.
    #
    #     The +:mode+ key of the hash can be used to configuring the filter
    #     mode. The mode has to be one of +:all+, +:any+, +:none+, +:empty+. It
    #     corresponds to the match type in {https://developer.gnome.org/libatspi/stable/AtspiMatchRule.html#atspi-match-rule-new atspi_match_rule_new} and
    #     {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCollectionMatchType AtspiCollectionMatchType}, accordingly.
    #
    #   @note Filtering attributes in mode +:all+ effectively disables the filter
    #     and returns all descendants. It does not narrow down the result set as
    #     one would expect.
    #
    #   @example
    #     # Selects accessibles with value "button" for attribute "tag"
    #     where(attributes: { "tag" => "button" })
    #
    #     # Selects accessibles with value "button" *or* "input" for attribute "tag"
    #     where(attributes: { "tag" => ["button", "input"] })
    #
    #     # Selects accessibles with value "button" for attribute "tag" *or* value "block" for attribute "display"
    #     where(attributes: { "tag" => "button", "display" => "block" })
    #
    # @overload where(role:)
    #   Filters by role
    #
    #   @param role [Symbol,Array<Symbol[, mode: :any]>] the roles filter.
    #     Roles are given as symbols derived from libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiRole AtspiRole enum}
    #     by removing the +ATSPI_ROLE_+ prefix and making it lowercase.
    #
    #     When given an array, the last item can be set to a hash configuring
    #     the filter mode. The mode has to be one of +:all+, +:any+, +:none+,
    #     +:empty+. It corresponds to the match type in {https://developer.gnome.org/libatspi/stable/AtspiMatchRule.html#atspi-match-rule-new atspi_match_rule_new} and
    #     {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCollectionMatchType AtspiCollectionMatchType}, accordingly.
    #
    #   @note Setting the mode to a value different from +:any+ for role filters
    #     effectively disables the filter and returns all descendants. Since an
    #     accessible has only exactly one role, one would expect that it does return an
    #     empty set, but it does not.
    #
    #   @example
    #     # Selects accessibles with role :frame
    #     where(role: :frame)
    #
    #     # Selects accessibles with role :page_tab_list *or* :page_tab
    #     where(role: [:page_tab_list, :page_tab])
    #
    # @overload where(interface:)
    #   Filters by interface(s)
    #
    #   @param role [Symbol,Array<Symbol[, mode: :all]>] the role filter.
    #     Interfaces are given as symbols derived from their name returned by
    #     {Accessible#interfaces}
    #
    #     When given an array, the last item can be set to a hash configuring
    #     the filter mode. The mode has to be one of +:all+, +:any+, +:none+,
    #     +:empty+. It corresponds to the match type in {https://developer.gnome.org/libatspi/stable/AtspiMatchRule.html#atspi-match-rule-new atspi_match_rule_new} and
    #     {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCollectionMatchType AtspiCollectionMatchType}, accordingly.
    #
    #   @note Filtering by multiple interfaces and including +:Accessible+ or
    #     +:Collection+ in mode +:all+ does not work. Instead it always returns
    #     an empty set.
    #
    #   @note Filtering interfaces in mode +:none+ effectively disables the filter
    #     and returns the entire set of descendants. Since an accessible always
    #     has at least the accessible interfaces it implements one would expect
    #     that it does return an empty set, but it does not.
    #
    #   @example
    #     # Selects accessibles implementing Action
    #     where(interface: :Action)
    #
    #     # Selects accessibles implementing Action+ *and* Selection
    #     where(interface: [:Action, :Selection])
    #
    #     # Selects accessibles implementing Action *or* +Selection or both
    #     where(interface: [:Action, :Selection, mode: :any])
    #
    # @overload where(name:)
    #   Filters by name
    #
    #   @param name [String,RegExp] the name filter. When given a string it is
    #     matched against the entire name from start to end like +/^name$/+.
    #
    #   @example
    #     # Selects accessibles with name exactly "Accessibles Name"
    #     where(name: "Accessible Name")
    #
    #     # Selects accessibles with a name matching /a.{11}y/
    #     where(name: /a.{11}y/)
    #
    # @overload where(filters)
    #   Combines all or a subset of filters in a single call.
    #
    #   @example
    #     where(name: /a.{11}y/, state: [:selectable, :selected], role: :page_tab)
    #
    #   @param filters [Hash]
    #   @option filters [Symbol, Array] :states
    #   @option filters [Symbol, Array] :role
    #   @option filters [String, RegExp] :name
    #   @option filters [Hash] :attributes
    #   @option filters [Symbol, Array] :interface
    def where(filters)
      dup(filters: @filters.map do |name, filter|
        extended_filter = filters[name] ? filter.extend(*filters[name]) : filter
        [name, extended_filter]
      end.to_h)
    end

    # Inverts the conditions set by {#where}.
    #
    # @note Seems to be not considered by libatspi?!
    #
    # @param invert [true, false]
    #
    # @return [Descendants] a copy of the current descendants with the modified
    #   _inverted_ option.
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiMatchRule.html#atspi-match-rule-new invert parameter of atspi_match_rule_new
    def invert(invert = true)
      dup(options: @options.invert(invert))
    end
  # @!endgroup

  # @!group Options
    # Sorts the collection of descendants.
    #
    # @param order [Symbol] derived from libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiCollectionSortOrder AtspiCollectionSortOrder enum}
    #   by removing the prefix +ATSPI_Collection_SORT_ORDER_+ and making it lowercase.
    #
    # @return [Descendants] a copy of the current descendants with the modified
    #   _order_ option.
    #
    # @example
    #   descendants.sort_by(:flow) # => #<ATSPI::Accessible::Descendants:0x101c51014 … >
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-collection.html#atspi-collection-get-matches sortby parameter of atspi_collection_get_matches
    def sort_by(order)
      dup(options: @options.order_by(order))
    end

    # Limits the number of descendants to return.
    #
    # @param limit [Integer] A value of +0+ disables the limit.
    #
    # @return [Descendants] a copy of the current descendants with the modified
    #   _limit_ option.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-collection.html#atspi-collection-get-matches count parameter of atspi_collection_get_matches
    def limit_to(limit)
      dup(options: @options.limit_to(limit))
    end

    # Turns recursive search on and off.
    #
    # @param recursive [true, false] To limit the descendants to the direct
    #   children of the accessible only, set +recursive+ to +false+. By setting
    #   +recursive+ to +true+, all descendants in the tree below the accessible
    #   the descendants are considered.
    #
    # @return [Descendants] a copy of the current descendants with the modified
    #   _recursive_ option.
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-collection.html#atspi-collection-get-matches traverse parameter of atspi_collection_get_matches
    def recursive(recursive = true)
      dup(options: @options.recursive(recursive))
    end
  # @!endgroup

  # @!group Access
    # @return [Array<Accessible>] the descendants according to the configured
    #   filters and options. The collection will be empty if the accessible
    #   does not implement the {https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-collection collection interface}
    def to_a
      return [] unless @native.collection_iface
      match_rule = Libatspi::MatchRule.new(*@filters[:state], *@filters[:attributes],
        *@filters[:role], *@filters[:interface], @options.inverted?)
      matches = @native.matches(match_rule, *@options).to_a
      matches = matches.select{ |native| native.name =~ @filters[:name].match } if @filters[:name].match
      matches.map{ |native| Accessible.new(native) }
    end

    # Delegates missing methods to #to_a
    # @return [Object] whatever Array#__send__(m, *args, &block) returns
    def method_missing(m, *args, &block)
      to_a.__send__(m, *args, &block)
    end
  # @!endgroup

  # @!group Selection
    # @return [Array<Accessible>] its selected subset.
    def selected
      select(&:selected?)
    end

    # Tries to select all descendants in the collection
    #
    # @return [true,false] indicates if *all* are now selected
    def select_all
      map(&:select).all?
    end

    # Tries to deselect all descendants in the collection
    #
    # @return [true,false] indicates if *all* are now deselected
    def deselect_all
      map(&:deselect).all?
    end
  # @!endgroup

  # @!group Representations
    # @return [String] itself as an inspectable string
    def inspect
      filter_inspect = @filters.map{ |n,f| "@#{n}=#{f.inspect}" }.join(' ')
      "#<#{self.class.name}:0x#{'%x14' % __id__} #{filter_inspect} #{@options.inspect}>"
    end
  # @!endgroup

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