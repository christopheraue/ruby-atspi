module ATSPI
  # The {ErrorAccessible} is used for accessibles that cannot be instantiated
  # due to errors. It responds to the interface of {Accessible} and returns
  # dummy values.
  class ErrorAccessible
    include Accessible::Extents
    def extends?
      false
    end

    include Accessible::Selectable
    def selectable?
      false
    end

    # @api private
    def initialize(native)
      @native = native
    end

    attr_reader :native
    private :native

  # @!group Identification
    # @return [nil] no desktop
    def desktop
      nil
    end

    # @return [nil] no application
    def application
      nil
    end

    # @return [nil] no window
    def window
      nil
    end

    # @return [-1] an invalid index
    def index_in_parent
      -1
    end
    alias_method :index, :index_in_parent

    # @return [{}] an empty path
    def path
      []
    end
  # @!endgroup

  # @!group Attributes & States
    # @return [String] its inspection
    def name
      inspect
    end

    # @return [String] its inspection
    def description
      inspect
    end

    # @return [:invalid]
    def role
      :invalid
    end

    # @return ['Invalid']
    def role_name
      'Invalid'
    end

    # @return ['Invalid']
    def localized_role_name
      'Invalid'
    end

    # @return [''] an empty string
    def toolkit_name
      ''
    end

    # @return [''] an empty string
    def toolkit_version
      ''
    end

    # @return [StateSet] an empty state set
    def states
      StateSet.new
    end

    # @return [{}] an empty hash
    def attributes
      {}
    end

    # @return [[]] no interfaces
    def interfaces
      []
    end
  # @!endgroup

  # @!group Tree & Traversal
    # @return [nil] no parent
    def parent
      nil
    end

    # @return [[]] no children
    def children
      []
    end

    # @return [[]] no descendants
    def descendants
      []
    end

    # @return [nil]
    def descendant_by_path(*path)
      nil
    end

    # @return [{}] no relations
    def relations
      {}
    end
  # @!endgroup

  # @!group Actions
    # @return [[]] it supports no actions
    def actions
      []
    end
  # @!endgroup

  # @!group Representative for
    # @return [nil] no document
    def document
      nil
    end

    # @return [nil] no text
    def text
      nil
    end

    # @return [nil] no hyperlink
    def hyperlink
      nil
    end
    alias_method :link, :hyperlink

    # @return [nil] no image
    def image
      nil
    end

    # @return [nil] no value
    def value
      nil
    end

    # @return [nil] no table
    def table
      nil
    end
  # @!endgroup

  # @!group Representations
    # @return [String] itself as an inspectable string
    def inspect
      "#<#{self.class.name}:0x#{'%x14' % __id__}>"
    end
  # @!endgroup
  end
end
