  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE changed_by FROM cls_attribute INTO rv_user
      WHERE name = ms_item-obj_name
      AND activation_state = 'A'.

    IF rv_user IS INITIAL.
      SELECT SINGLE created_by FROM cls_attribute INTO rv_user
        WHERE name = ms_item-obj_name
        AND activation_state = 'A'.
    ENDIF.

    IF rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.