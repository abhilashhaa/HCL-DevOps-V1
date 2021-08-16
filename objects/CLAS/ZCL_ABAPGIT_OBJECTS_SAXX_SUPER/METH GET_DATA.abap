  METHOD get_data.

    DATA: lv_object_key TYPE seu_objkey.

    lv_object_key = ms_item-obj_name.

    TRY.
        mi_persistence->get(
          EXPORTING
            p_object_key  = lv_object_key
            p_version     = 'A'
          CHANGING
            p_object_data = mi_appl_obj_data ).

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |{ ms_item-obj_type } not supported| ).
    ENDTRY.

    mi_appl_obj_data->get_data( IMPORTING p_data = eg_data ).

  ENDMETHOD.