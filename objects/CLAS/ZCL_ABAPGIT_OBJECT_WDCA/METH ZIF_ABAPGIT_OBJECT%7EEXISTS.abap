  METHOD zif_abapgit_object~exists.
    DATA: ls_wdy_config_appl TYPE wdy_config_appl.
    DATA: ls_wdy_config_key TYPE wdy_config_key.

    ls_wdy_config_key = ms_item-obj_name.
    SELECT SINGLE * FROM wdy_config_appl
      INTO ls_wdy_config_appl
      WHERE config_id = ls_wdy_config_key-config_id
        AND config_type = ls_wdy_config_key-config_type
        AND config_var = ls_wdy_config_key-config_var.  "#EC CI_GENBUFF
    rv_bool = boolc( sy-subrc = 0 ).
  ENDMETHOD.