  METHOD delete.

    lock( iv_type  = iv_type
          iv_value = iv_value ).

    DELETE FROM (c_tabname)
      WHERE type = iv_type
      AND value = iv_value.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'DB Delete failed' ).
    ENDIF.

  ENDMETHOD.