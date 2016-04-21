class ATSPI::Accessible
  class Hyperlink
    extend Forwardable

    def initialize(hyperlink_native)
      @hyperlink_native = hyperlink_native
    end

    def anchors
      @hyperlink_native.n_anchors.times.map do |idx|
        Anchor.new(@hyperlink_native, idx)
      end
    end

    delegate :is_valid => :@hyperlink_native
    alias_method :valid?, :is_valid

    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__} @anchors=#{anchors.inspect}>"
    end
  end
end