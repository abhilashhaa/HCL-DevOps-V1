  METHOD zif_abapgit_object~delete.

    DATA: lv_program LIKE sy-repid.

    lv_program = ms_item-obj_name.

    CALL FUNCTION 'RS_DELETE_PROGRAM'
      EXPORTING
        program                    = lv_program
        suppress_popup             = abap_true
        force_delete_used_includes = abap_true
      EXCEPTIONS
        enqueue_lock               = 1
        object_not_found           = 2
        permission_failure         = 3
        reject_deletion            = 4
        OTHERS                     = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from RS_DELETE_PROGRAM: { sy-subrc }| ).
    ENDIF.

    delete_longtexts( c_longtext_id_prog ).

  ENDMETHOD.