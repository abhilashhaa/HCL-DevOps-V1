  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE lastuser FROM fplayout
      INTO rv_user
      WHERE name = ms_item-obj_name
      AND state = 'A'.
    IF rv_user IS INITIAL.
      SELECT SINGLE firstuser FROM fplayout
        INTO rv_user
        WHERE name = ms_item-obj_name
        AND state = 'A'.
    ENDIF.
    IF rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.