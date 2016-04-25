Libatspi.load_class :StateSet

module ATSPI
  # ATSPI::StateSet wraps libatspi's AtspiStateSet[https://developer.gnome.org/libatspi/stable/AtspiStateSet.html]
  class StateSet
    extend Forwardable

    # @!visibility private
    def self.new_from_native(native)
      new(*native.states)
    end

  # @!group Lifecycle
    # @param states [Symbols] zero, one or more symbols derived from
    #   libatspi's {AtspiStateType enum}[https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiStateType]
    #   by removing the prefix +ATSPI_STATE_+ and making it lowercase.
    #
    # @return [StateSet]
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-new atspi_state_set_new
    def initialize(*states)
      @native = Libatspi::StateSet.new(states)
    end
  # @!endgroup

    # @!visibility private
    attr_reader :native
    private :native
    # @!visibility public

  # @!group Modification
    # Adds states to the set
    #
    # @param states [Symbols] zero, one or more symbols derived from
    #   libatspi's {AtspiStateType enum}[https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiStateType]
    #   by removing the prefix +ATSPI_STATE_+ and making it lowercase.
    #
    # @return [self]
    #
    # @example
    #   s = ATSPI::StateSet.new   # => #<ATSPI::StateSet:0x15ae28014 @states=[]>
    #   s.add(:active, :enabled)  # => #<ATSPI::StateSet:0x15ae28014 @states=[:active, :enabled]>
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-add atspi_state_set_add
    def add(*states)
      states.each{ |state| @native.add(state) }
      self
    end

    # Removes states from the set
    #
    # @param states [Symbols] zero, one or more symbols derived from
    #   libatspi's {AtspiStateType enum}[https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiStateType]
    #   by removing the prefix +ATSPI_STATE_+ and making it lowercase.
    #
    # @return [self]
    #
    # @example
    #   s = ATSPI::StateSet.new(:active, :enabled)  # => #<ATSPI::StateSet:0x15ae28014 @states=[:active, :enabled]>
    #   s.remove(:active)                           # => #<ATSPI::StateSet:0x15ae28014 @states=[:enabled]>
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-remove atspi_state_set_remove
    def remove(*states)
      states.each{ |state| @native.remove(state) }
      self
    end
  # @!endgroup

  # @!group Queries
    # Checks if it contains the given state
    #
    # @param state [Symbol] the state as symbol derived from libatspi's
    #   {AtspiStateType enum}[https://developer.gnome.org/libatspi/stable/libatspi-atspi-constants.html#AtspiStateType]
    #   by removing the prefix +ATSPI_STATE_+ and making it lowercase.
    #
    # @return [true,false]
    #
    # @example
    #   ATSPI::StateSet.new(:active, :editable).contains?(:active) # => true
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-contains atspi_state_set_contains
    def contains?(state)
      @native.contains(state)
    end

    # Checks if it is empty
    #
    # @return [true,false]
    #
    # @example
    #   ATSPI::StateSet.new(:active, :editable).empty? # => false
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-is-empty atspi_state_set_is_empty
    def empty?
      @native.is_empty
    end

    # Returns the difference between it and another set
    #
    # @return [StateSet] the difference to the given set
    #
    # @example
    #   s1 = ATSPI::StateSet.new(:active, :editable)  # => #<ATSPI::StateSet:0x15ae28014 @states=[:active, :editable]>
    #   s2 = ATSPI::StateSet.new(:active, :enabled)   # => #<ATSPI::StateSet:0x119ea8c14 @states=[:active, :enabled]>
    #   s1.difference_to(s2)                          # => #<ATSPI::StateSet:0x110b2b414 @states=[:editable, :enabled]>
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-compare atspi_state_set_compare
    def difference_to(state_set)
      StateSet.new_from_native @native.compare(state_set.__send__(:native))
    end
    alias_method :^, :difference_to

    # Checks if it equals another set
    #
    # @return [true, false]
    #
    # @example
    #   s1 = ATSPI::StateSet.new(:active, :editable)  # => #<ATSPI::StateSet:0x15ae28014 @states=[:active, :editable]>
    #   s2 = ATSPI::StateSet.new(:active, :enabled)   # => #<ATSPI::StateSet:0x119ea8c14 @states=[:active, :enabled]>
    #   s1.equals?(s2)                                # => false
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-equals atspi_state_set_equals
    def equals?(state_set)
      @native.equals state_set.__send__(:native)
    end
    alias_method :==, :equals?
  # @!endgroup

  # @!group Representations
    # @return [Array<Symbol>] the states it contains
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiStateSet.html#atspi-state-set-get-states atspi_state_set_get_states
    def to_a
      @native.states.to_a
    end

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @states=#{to_a.inspect}>"
    end
  # @!endgroup
  end
end