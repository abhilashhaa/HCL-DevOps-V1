  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE chgname1 FROM tsp1d INTO rv_user
      WHERE papart = ms_item-obj_name.
    IF sy-subrc <> 0 OR rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.