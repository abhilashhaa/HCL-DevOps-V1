  METHOD zif_abapgit_object~delete.
    DATA: ls_config_key TYPE wdy_config_key,
          lv_subrc      TYPE sysubrc.

    ls_config_key-config_id = ms_item-obj_name+0(32).
    ls_config_key-config_type = '00'.

    TRY.
        " does not exist in 702
        CALL METHOD cl_wdr_cfg_persistence_utils=>('DELETE_CONFIGURATION')
          EXPORTING
            config_key = ls_config_key
          RECEIVING
            subrc      = lv_subrc.
        IF lv_subrc <> 0.
          zcx_abapgit_exception=>raise( 'Error deleting WDCC: ' && ms_item-obj_name ).
        ENDIF.
      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'Object type WDCC not supported for this release' ).
    ENDTRY.

  ENDMETHOD.