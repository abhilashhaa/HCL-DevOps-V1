  METHOD zif_abapgit_object~exists.

    DATA: lv_tabname TYPE dd02l-tabname.

    lv_tabname = ms_item-obj_name.
    CALL FUNCTION 'DD_GET_NAMETAB_HEADER'
      EXPORTING
        tabname   = lv_tabname
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.