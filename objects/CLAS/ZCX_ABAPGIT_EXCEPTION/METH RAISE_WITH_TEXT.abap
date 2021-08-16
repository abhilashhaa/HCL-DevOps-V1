  METHOD raise_with_text.
    raise(
      iv_text = ix_previous->get_text( )
      ix_previous = ix_previous ).
  ENDMETHOD.