  METHOD clear.
    IF mv_read_only = abap_true.
      zcx_abapgit_exception=>raise( 'Cannot clear. This string map is immutable' ).
    ENDIF.
    CLEAR mt_entries.
  ENDMETHOD.