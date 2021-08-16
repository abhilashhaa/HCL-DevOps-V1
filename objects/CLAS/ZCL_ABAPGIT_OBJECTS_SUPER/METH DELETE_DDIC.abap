  METHOD delete_ddic.

    DATA: lv_objname TYPE rsedd0-ddobjname,
          lv_objtype TYPE rsedd0-ddobjtype.

    lv_objname = ms_item-obj_name.
    lv_objtype = iv_objtype.

    TRY.
        CALL FUNCTION 'RS_DD_DELETE_OBJ'
          EXPORTING
            no_ask               = iv_no_ask
            objname              = lv_objname
            objtype              = lv_objtype
            no_ask_delete_append = iv_no_ask_delete_append
          EXCEPTIONS
            not_executed         = 1
            object_not_found     = 2
            object_not_specified = 3
            permission_failure   = 4
            dialog_needed        = 5
            OTHERS               = 6.
      CATCH cx_sy_dyn_call_param_not_found.
        " no_ask_delete_append not available in lower releases
        CALL FUNCTION 'RS_DD_DELETE_OBJ'
          EXPORTING
            no_ask               = iv_no_ask
            objname              = lv_objname
            objtype              = lv_objtype
          EXCEPTIONS
            not_executed         = 1
            object_not_found     = 2
            object_not_specified = 3
            permission_failure   = 4
            dialog_needed        = 5
            OTHERS               = 6.
    ENDTRY.

    IF sy-subrc = 5.
      zcx_abapgit_exception=>raise( |Object { ms_item-obj_type } { ms_item-obj_name
                                    } has dependencies and must be deleted manually| ).
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error deleting { ms_item-obj_type } { ms_item-obj_name }| ).
    ENDIF.

  ENDMETHOD.