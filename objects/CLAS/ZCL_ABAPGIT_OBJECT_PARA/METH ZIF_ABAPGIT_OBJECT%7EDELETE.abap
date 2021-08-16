  METHOD zif_abapgit_object~delete.

    " We can't use FM RS_PARAMETER_DELETE because of the popup to confirm
    "Therefore we have to reimplement most of the FMs logic

    DATA: lv_paramid   TYPE tpara-paramid,
          ls_transpkey TYPE trkey.

    lv_paramid = ms_item-obj_name.

    CALL FUNCTION 'RS_ACCESS_PERMISSION'
      EXPORTING
        global_lock              = abap_true
        language_upd_exit        = 'RS_PARAMETER_LANGUAGE_EXIT'    " Name FuBa for maintenance language change
        object                   = lv_paramid
        object_class             = ms_item-obj_type
        suppress_language_check  = space
      EXCEPTIONS
        canceled_in_corr         = 1
        enqueued_by_user         = 2
        enqueue_system_failure   = 3
        illegal_parameter_values = 4
        locked_by_author         = 5
        no_modify_permission     = 6
        no_show_permission       = 7
        permission_failure       = 8
        request_language_denied  = 9
        OTHERS                   = 10.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    SELECT COUNT(*) FROM cross
      WHERE ( type = 'P' OR type = 'Q' ) AND name = lv_paramid.
    IF sy-subrc = 0.
      zcx_abapgit_exception=>raise( 'PARA: Parameter is still used' ).
    ELSE.
      SELECT COUNT(*) FROM dd04l BYPASSING BUFFER
        WHERE memoryid = lv_paramid
        AND as4local = 'A'.
      IF sy-subrc = 0.
        zcx_abapgit_exception=>raise( 'PARA: Parameter is still used' ).
      ENDIF.
    ENDIF.
    CALL FUNCTION 'RS_CORR_INSERT'
      EXPORTING
        global_lock         = abap_true
        object              = lv_paramid
        object_class        = 'PARA'
        mode                = 'D'
        suppress_dialog     = abap_true
      IMPORTING
        transport_key       = ls_transpkey
      EXCEPTIONS
        cancelled           = 01
        permission_failure  = 02
        unknown_objectclass = 03.

    IF sy-subrc = 0.
      DELETE FROM tpara WHERE paramid = lv_paramid.
      DELETE FROM tparat WHERE paramid = lv_paramid.

      IF sy-subrc = 0.
        CALL FUNCTION 'RS_TREE_OBJECT_PLACEMENT'
          EXPORTING
            object    = lv_paramid
            operation = 'DELETE'
            type      = 'CR'.
      ENDIF.
    ELSE.
      zcx_abapgit_exception=>raise( 'error from RS_CORR_INSERT' ).
    ENDIF.

    CALL FUNCTION 'RS_ACCESS_PERMISSION'
      EXPORTING
        mode         = 'FREE'
        object       = lv_paramid
        object_class = 'PARA'.

  ENDMETHOD.