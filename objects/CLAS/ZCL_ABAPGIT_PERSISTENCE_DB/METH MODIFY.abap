  METHOD modify.

    DATA: ls_content TYPE zif_abapgit_persistence=>ty_content.

    lock( iv_type  = iv_type
          iv_value = iv_value ).

    ls_content-type  = iv_type.
    ls_content-value = iv_value.
    ls_content-data_str = iv_data.

    MODIFY (c_tabname) FROM ls_content.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'DB modify failed' ).
    ENDIF.

  ENDMETHOD.