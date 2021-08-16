  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE as4user FROM dd40l INTO rv_user
      WHERE typename = ms_item-obj_name
      AND as4local = 'A'.
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.