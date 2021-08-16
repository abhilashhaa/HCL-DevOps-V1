  METHOD zif_abapgit_log~get_title.
    rv_title = mv_title.
    IF rv_title IS INITIAL.
      rv_title = 'Log'.
    ENDIF.
  ENDMETHOD.