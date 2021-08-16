  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE modifier INTO rv_user FROM scprattr
      WHERE id = ms_item-obj_name
      AND version = 'N'.
    IF sy-subrc <> 0 OR rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.