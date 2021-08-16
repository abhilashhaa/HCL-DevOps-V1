  METHOD zif_abapgit_object~changed_by.

    DATA: ls_outline    TYPE wdy_cfg_outline_data,
          ls_config_key TYPE wdy_config_key.

    ls_config_key-config_id = ms_item-obj_name+0(32).
    ls_config_key-config_type = '00'.

    TRY.
        cl_wdr_cfg_persistence_utils=>read_comp_config_from_db(
          EXPORTING
            config_key   = ls_config_key
          IMPORTING
            outline_data = ls_outline ).
      CATCH cx_static_check.
        zcx_abapgit_exception=>raise( 'Error Reading Component Config from DB: ' && ms_item-obj_name ).
    ENDTRY.

    rv_user = ls_outline-changedby.

  ENDMETHOD.