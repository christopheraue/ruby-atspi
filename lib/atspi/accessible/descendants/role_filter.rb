module ATSPI
  class Accessible::Descendants
    class RoleFilter
      def initialize(mode: :any, roles: [])
        @mode = mode
        @roles = roles
      end

      def extend(*roles, mode: @mode)
        self.class.new(mode: mode, roles: (@roles + roles).uniq)
      end

      def to_a
        [@roles.dup, @mode]
      end

      def inspect
        "#{@mode}:#{@roles.inspect}"
      end
    end
  end
end