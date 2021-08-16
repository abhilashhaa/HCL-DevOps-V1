  METHOD delete.

    IF mv_read_only = abap_true.
      zcx_abapgit_exception=>raise( 'Cannot delete. This string map is immutable' ).
    ENDIF.

    DELETE mt_entries WHERE k = iv_key.

  ENDMETHOD.