  METHOD zif_abapgit_object~exists.

    DATA: lv_rollname TYPE dd04l-rollname.

    lv_rollname = ms_item-obj_name.
    CALL FUNCTION 'DD_GET_NAMETAB_HEADER'
      EXPORTING
        tabname   = lv_rollname
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.