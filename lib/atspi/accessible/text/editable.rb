class ATSPI::Accessible::Text
  # Wraps libatspi's {https://developer.gnome.org/libatspi/stable/libatspi-atspi-editabletext.html#AtspiEditableText editable_text interface}.
  module Editable
  # @!group Attributes & States
    # Checks if it is editable.
    #
    # @return [true,false]
    #
    # @see https://developer.gnome.org/libatspi/stable/AtspiAccessible.html#atspi-accessible-get-editable-text atspi_accessible_get_editable_text_iface
    def editable?
      not @native.editable_text_iface.nil?
    end
  # @!endgroup

  # @!group Actions
    # Replaces its content with the given one. Will succeed only if it's
    # editable.
    #
    # @param text [respond to #to_s] the new text
    #
    # @return [true,false] indicating success
    def set_to(text)
      delete && insert(text.to_s)
    end

    # Inserts a string at the given offset. Will succeed only if it's editable.
    #
    # @param text [respond to #to_s] the text to insert
    # @param at [responds to #to_i] the offset to insert the string at
    #
    # @return [true,false] indicating success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-editabletext.html#atspi-editable-text-insert-text atspi_editable_text_insert_text
    def insert(text, at: caret)
      editable? and @native.insert_text(at.to_i, text.to_s, text.to_s.length)
    end

    # Pastes the string in the clipboard at the given offset. Will succeed
    # only if it's editable.
    #
    # @param at [responds to #to_i] the offset to insert the string at
    #
    # @return [true,false] indicating success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-editabletext.html#atspi-editable-text-paste-text atspi_editable_text_paste_text
    def paste(at: caret)
      editable? and @native.paste_text(at.to_i)
    end

    # Copies its content in the given range into the clipboard. Will succeed
    # only if it's editable.
    #
    # @param from [responds to #to_i] the start offset of the range
    # @param to [responds to #to_i] the end offset of the range
    #
    # @return [true,false] indicating success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-editabletext.html#atspi-editable-text-copy-text atspi_editable_text_copy_text
    def copy(from: 0, to: length)
      editable? and @native.copy_text(from.to_i, to.to_i)
    end

    # Cuts its content in the given range and puts it into the clipboard. Will
    # succeed only if it's editable.
    #
    # @param from [responds to #to_i] the start offset of the range
    # @param to [responds to #to_i] the end offset of the range
    #
    # @return [true,false] indicating success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-editabletext.html#atspi-editable-text-cut-text atspi_editable_text_cut_text
    def cut(from: 0, to: length)
      editable? and @native.cut_text(from.to_i, to.to_i)
    end

    # Deletes its content in the given range. Will succeed only if it's
    # editable.
    #
    # @param from [responds to #to_i] the start offset of the range
    # @param to [responds to #to_i] the end offset of the range
    #
    # @return [true,false] indicating success
    #
    # @see https://developer.gnome.org/libatspi/stable/libatspi-atspi-editabletext.html#atspi-editable-text-delete-text atspi_editable_text_delete_text
    def delete(from: 0, to: length)
      editable? and @native.delete_text(from.to_i, to.to_i)
    end
  # @!endgroup
  end
end