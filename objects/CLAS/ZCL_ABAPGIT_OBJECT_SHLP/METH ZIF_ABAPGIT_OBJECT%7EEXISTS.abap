  METHOD zif_abapgit_object~exists.

    DATA: lv_shlpname TYPE dd30l-shlpname.


    SELECT SINGLE shlpname FROM dd30l INTO lv_shlpname
      WHERE shlpname = ms_item-obj_name
      AND as4local = 'A'.                               "#EC CI_GENBUFF
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.