class ATSPI::Accessible::Text
  module Editable
    def editable?
      not @native.editable_text_iface.nil?
    end

    def text=(text)
      delete
      insert(text)
    end
    alias_method :value=, :text=
    alias_method :content=, :text=

    def insert(text, at: caret.offset)
      editable? and @native.insert_text(at, text, text.length)
    end

    def paste(at: caret.offset)
      editable? and @native.paste_text(at)
    end

    def copy(from: 0, to: length)
      editable? and @native.copy_text(from, to)
    end

    def cut(from: 0, to: length)
      editable? and @native.cut_text(from, to)
    end

    def delete(from: 0, to: length)
      editable? and @native.delete_text(from, to)
    end
  end
end