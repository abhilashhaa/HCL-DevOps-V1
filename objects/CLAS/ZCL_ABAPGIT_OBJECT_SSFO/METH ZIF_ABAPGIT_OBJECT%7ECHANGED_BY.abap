  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE lastuser FROM stxfadm INTO rv_user
      WHERE formname = ms_item-obj_name.
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.