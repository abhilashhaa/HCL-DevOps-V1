  METHOD zif_abapgit_object~delete.

    DATA: lv_object_key TYPE seu_objkey.

    create_channel_objects( ).

    lv_object_key = ms_item-obj_name.

    TRY.
        lock( ).

        mi_persistence->delete( lv_object_key ).

        unlock( ).

      CATCH cx_swb_exception.
        zcx_abapgit_exception=>raise( |Error occured while deleting { ms_item-obj_type }| ).
    ENDTRY.

  ENDMETHOD.