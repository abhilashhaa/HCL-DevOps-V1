  METHOD update_extras.

    IF is_tabl_extras-tddat IS INITIAL.
      delete_extras( iv_tabname = iv_tabname ).
    ELSE.
      MODIFY tddat FROM is_tabl_extras-tddat.
    ENDIF.

  ENDMETHOD.