  METHOD zif_abapgit_object~changed_by.

    DATA ls_key TYPE wdy_config_key.

    ls_key = ms_item-obj_name.

    SELECT SINGLE changedby FROM wdy_config_appl INTO rv_user
      WHERE config_id = ls_key-config_id AND config_type = ls_key-config_type AND config_var = ls_key-config_var.
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.