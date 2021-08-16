  METHOD update.

    DATA lv_data LIKE iv_data.

    lv_data = validate_and_unprettify_xml( iv_data ).

    lock( iv_type  = iv_type
          iv_value = iv_value ).

    UPDATE (c_tabname) SET data_str = lv_data
      WHERE type  = iv_type
      AND value = iv_value.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'DB update failed' ).
    ENDIF.

  ENDMETHOD.