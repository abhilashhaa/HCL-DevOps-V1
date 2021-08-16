  METHOD zif_abapgit_object~exists.

    DATA: lv_objectname TYPE objh-objectname,
          lv_type_pos   TYPE i.

    lv_type_pos = strlen( ms_item-obj_name ) - 1.

    SELECT SINGLE objectname FROM objh INTO lv_objectname
      WHERE objectname = ms_item-obj_name(lv_type_pos)
      AND objecttype = ms_item-obj_name+lv_type_pos.    "#EC CI_GENBUFF
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.