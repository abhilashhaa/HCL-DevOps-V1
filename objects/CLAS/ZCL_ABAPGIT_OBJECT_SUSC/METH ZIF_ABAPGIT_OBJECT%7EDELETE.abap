  METHOD zif_abapgit_object~delete.

    CONSTANTS lc_activity_delete_06 TYPE activ_auth VALUE '06'.

    DATA: lv_auth_object_class TYPE tobc-oclss.


    lv_auth_object_class = ms_item-obj_name.

    TRY.
        me->zif_abapgit_object~exists( ).
      CATCH zcx_abapgit_exception.
        RETURN.
    ENDTRY.

    has_authorization( iv_class    = lv_auth_object_class
                       iv_activity = lc_activity_delete_06 ).

    is_used( lv_auth_object_class ).

    delete_class( lv_auth_object_class ).

    put_delete_to_transport( ).

  ENDMETHOD.