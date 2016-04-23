require 'atspi/requires'

module ATSPI
  class << self
    extend Forwardable

    def desktops
      @desktops ||= Libatspi.get_desktop_count.times.map do |idx|
        Desktop.new(Libatspi.get_desktop(idx))
      end
    end

    def applications(desktop = desktops.first)
      desktop.applications
    end

    delegate %i(generate_keyboard_event generate_mouse_event) => :Libatspi
  end

  class Error < StandardError; end
end