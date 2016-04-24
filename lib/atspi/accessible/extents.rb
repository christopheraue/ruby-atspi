class ATSPI::Accessible
  module Extents
    def component?
      not @native.component_iface.nil?
    end

    def layer
      if component?
        @native.layer
      else
        :invalid
      end
    end

    def mdi_z_order
      if component?
        @native.mdi_z_order
      else
        -1
      end
    end

    def grab_focus
      component? and @native.grab_focus
    end

    def alpha
      if component?
        @native.alpha
      else
        0.0
      end
    end

    def contains?(x, y, relative_to:)
      component? and @native.contains(x, y, relative_to)
    end

    def accessible_at_point(x, y, relative_to:)
      if component?
        ATSPI::Accessible.new(@native.accessible_at_point(x, y, relative_to))
      else
        nil
      end
    end

    def extents(relative_to:)
      if component?
        ATSPI::Extents.new(@native.extents(relative_to))
      else
        ATSPI::Extents.new(Struct.new(:x, :y, :width, :height).new(0, 0, 0, 0))
      end
    end
  end
end