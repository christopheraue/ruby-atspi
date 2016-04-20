class ATSPI::Accessible
  class Action
    def initialize(native, idx)
      @native = native
      @idx = idx
    end

    def name
      @native.action_name(@idx)
    end

    def description
      @native.action_description(@idx)
    end

    def key_binding
      @native.key_binding(@idx)
    end

    def do
      @native.do_action(@idx)
    end

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @name=#{name.inspect} @description=#{description.inspect}>"
    end
  end
end