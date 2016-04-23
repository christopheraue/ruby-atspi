class ATSPI::Accessible::Descendants
  class NameFilter
    def initialize(match = nil)
      @match = match
    end

    attr_reader :match

    def extend(match)
      self.class.new(match.is_a?(Regexp) ? match : /^#{Regexp.quote(match)}$/)
    end

    def inspect
      @match.inspect
    end
  end
end