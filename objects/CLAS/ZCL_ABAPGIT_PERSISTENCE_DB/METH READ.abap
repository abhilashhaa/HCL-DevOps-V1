  METHOD read.

    SELECT SINGLE data_str FROM (c_tabname) INTO rv_data
      WHERE type = iv_type
      AND value = iv_value.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_abapgit_not_found.
    ENDIF.

  ENDMETHOD.