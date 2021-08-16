  METHOD zif_abapgit_object~changed_by.

    DATA: lv_type_pos TYPE i.

    lv_type_pos = strlen( ms_item-obj_name ) - 1.

    SELECT SINGLE luser FROM objh INTO rv_user
      WHERE objectname = ms_item-obj_name(lv_type_pos)
      AND objecttype = ms_item-obj_name+lv_type_pos.    "#EC CI_GENBUFF
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.