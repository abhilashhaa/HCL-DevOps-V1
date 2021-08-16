  METHOD get_key_fields.

    DATA: lv_table TYPE ddobjname.


    lv_table = iv_table.

    CALL FUNCTION 'DDIF_NAMETAB_GET'
      EXPORTING
        tabname   = lv_table
      TABLES
        dfies_tab = rt_keys
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    DELETE rt_keys WHERE keyflag = abap_false.

  ENDMETHOD.