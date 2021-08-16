  METHOD if_message~get_text.

    IF mv_text IS NOT INITIAL.
      result = mv_text.
    ELSEIF get_default_text( ) IS NOT INITIAL.
      result = get_default_text( ).
    ELSE.
      result = super->get_text( ).
    ENDIF.

  ENDMETHOD.