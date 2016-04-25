class ATSPI::Accessible
  # Wraps libatspi's AtspiAction[https://developer.gnome.org/libatspi/stable/libatspi-atspi-action.html]
  class Action
  # @!visibility private
    def initialize(native, idx)
      @native = native
      @idx = idx
    end
  # @!visibility public

    # @return [String] its name
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-action.html#atspi-action-get-name atspi_action_get_name
    def name
      @native.action_name(@idx)
    end

    # @return [String] its description
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-action.html#atspi-action-get-description atspi_action_get_description
    def description
      @native.action_description(@idx)
    end

    # @return [String] its key binding
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-action.html#atspi-action-get-key-binding atspi_action_get_key_binding
    def key_binding
      @native.key_binding(@idx)
    end

    # Tries to execute the action
    #
    # @return [true,false] indicating success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-action.html#atspi-action-do-action atspi_action_do_action
    def do_it!
      @native.do_action(@idx)
    end

    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @name=#{name.inspect} @description=#{description.inspect}>"
    end
  end
end