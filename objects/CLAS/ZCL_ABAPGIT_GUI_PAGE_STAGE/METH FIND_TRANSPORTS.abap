  METHOD find_transports.
    DATA: li_cts_api TYPE REF TO zif_abapgit_cts_api,
          ls_new     LIKE LINE OF rt_transports.

    FIELD-SYMBOLS: <ls_local> LIKE LINE OF it_local.

    li_cts_api = zcl_abapgit_factory=>get_cts_api( ).

    TRY.
        LOOP AT it_local ASSIGNING <ls_local> WHERE item IS NOT INITIAL.
          IF <ls_local>-item-obj_type IS NOT INITIAL AND
             <ls_local>-item-obj_name IS NOT INITIAL AND
             <ls_local>-item-devclass IS NOT INITIAL.

            IF li_cts_api->is_chrec_possible_for_package( <ls_local>-item-devclass ) = abap_false.
              EXIT. " Assume all other objects are also in packages without change recording

            ELSEIF li_cts_api->is_object_type_lockable( <ls_local>-item-obj_type ) = abap_true AND
                   li_cts_api->is_object_locked_in_transport( iv_object_type = <ls_local>-item-obj_type
                                                              iv_object_name = <ls_local>-item-obj_name ) = abap_true.

              ls_new-item = <ls_local>-item.

              ls_new-transport = li_cts_api->get_current_transport_for_obj(
                iv_object_type             = <ls_local>-item-obj_type
                iv_object_name             = <ls_local>-item-obj_name
                iv_resolve_task_to_request = abap_false ).

              INSERT ls_new INTO TABLE rt_transports.
            ENDIF.
          ENDIF.
        ENDLOOP.
      CATCH zcx_abapgit_exception.
        ASSERT 1 = 2.
    ENDTRY.

  ENDMETHOD.