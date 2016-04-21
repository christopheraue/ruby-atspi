class ATSPI::Accessible::Text
  module Editable
    def initialize(native)
      @native = native
    end

    def text=(text)
      delete
      insert(text)
    end
    alias_method :value=, :text=
    alias_method :content=, :text=

    def insert(text, at: caret.offset)
      @native.insert_text(at, text, text.length)
    end

    def paste(at: caret.offset)
      @native.paste_text(at)
    end

    def copy(from: 0, to: length)
      @native.copy_text(from, to)
    end

    def cut(from: 0, to: length)
      @native.cut_text(from, to)
    end

    def delete(from: 0, to: length)
      @native.delete_text(from, to)
    end
  end
end