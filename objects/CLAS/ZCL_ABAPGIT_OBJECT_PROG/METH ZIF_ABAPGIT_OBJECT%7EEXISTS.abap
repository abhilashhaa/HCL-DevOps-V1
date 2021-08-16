  METHOD zif_abapgit_object~exists.

    DATA: lv_progname TYPE reposrc-progname.

    SELECT SINGLE progname FROM reposrc INTO lv_progname
      WHERE progname = ms_item-obj_name
      AND r3state = 'A'.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.