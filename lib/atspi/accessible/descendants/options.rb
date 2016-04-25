class ATSPI::Accessible::Descendants
  # @api private
  class Options
    def initialize(prototype = nil, extensions = {})
      @prototype = prototype
      @extensions = extensions
    end

    def invert(invert = true)
      self.class.new(self, inverted?: invert)
    end

    def order_by(order)
      self.class.new(self, order: order)
    end

    def limit_to(limit)
      self.class.new(self, limit: limit)
    end

    def recursive(recursive = true)
      self.class.new(self, recursive?: recursive)
    end

    def inverted?
      @extensions.key?(:inverted?) ? @extensions[:inverted?] : @prototype.inverted?
    end

    def order
      @extensions.key?(:order) ? @extensions[:order] : @prototype.order
    end

    def limit
      @extensions.key?(:limit) ? @extensions[:limit] : @prototype.limit
    end

    def recursive?
      @extensions.key?(:recursive?) ? @extensions[:recursive?] : @prototype.recursive?
    end

    def to_a
      [order, limit, recursive?]
    end

    def inspect
      "@inverted?=#{inverted?} @order=#{order} @limit=#{limit} @recursive?=#{recursive?}"
    end
  end
end