  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE changed_by FROM intf INTO rv_user
      WHERE intf_name = ms_item-obj_name.
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.