  METHOD zif_abapgit_object~changed_by.

    DATA lv_changed_by TYPE sproxhdr-changed_by.

    rv_user = c_user_unknown.

    SELECT SINGLE changed_by
      FROM sproxhdr
      INTO lv_changed_by
      WHERE object = mv_object
      AND obj_name = mv_obj_name
      AND inactive = abap_false.

    IF sy-subrc = 0 AND lv_changed_by IS NOT INITIAL.
      rv_user = lv_changed_by.
    ENDIF.

  ENDMETHOD.