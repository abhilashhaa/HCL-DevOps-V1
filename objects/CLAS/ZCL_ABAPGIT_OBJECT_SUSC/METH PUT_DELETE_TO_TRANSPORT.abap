  METHOD put_delete_to_transport.

    DATA: lv_tr_object_name TYPE e071-obj_name,
          lv_tr_return      TYPE char1,
          ls_package_info   TYPE tdevc,
          lv_tadir_object   TYPE tadir-object,
          lv_tadir_obj_name TYPE tadir-obj_name.


    lv_tr_object_name = ms_item-obj_name.

    CALL FUNCTION 'SUSR_COMMEDITCHECK'
      EXPORTING
        objectname       = lv_tr_object_name
        transobjecttype  = transobjecttype_class
      IMPORTING
        return_from_korr = lv_tr_return.

    IF lv_tr_return <> 'M'.
      zcx_abapgit_exception=>raise( |error in SUSC delete at SUSR_COMMEDITCHECK| ).
    ENDIF.

    CALL FUNCTION 'TR_DEVCLASS_GET'
      EXPORTING
        iv_devclass = ms_item-devclass
      IMPORTING
        es_tdevc    = ls_package_info
      EXCEPTIONS
        OTHERS      = 1.
    IF sy-subrc = 0 AND ls_package_info-korrflag IS INITIAL.
      lv_tadir_object   = ms_item-obj_type.
      lv_tadir_obj_name = lv_tr_object_name.
      CALL FUNCTION 'TR_TADIR_INTERFACE'
        EXPORTING
          wi_delete_tadir_entry = abap_true
          wi_test_modus         = space
          wi_tadir_pgmid        = 'R3TR'
          wi_tadir_object       = lv_tadir_object
          wi_tadir_obj_name     = lv_tadir_obj_name
        EXCEPTIONS
          OTHERS                = 0.
    ENDIF.

  ENDMETHOD.