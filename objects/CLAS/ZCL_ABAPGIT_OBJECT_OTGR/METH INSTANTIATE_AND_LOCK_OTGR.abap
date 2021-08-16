  METHOD instantiate_and_lock_otgr.
    DATA: lv_new  TYPE abap_bool,
          lv_name TYPE cls_attribute_name.

    SELECT SINGLE name FROM cls_type_group INTO lv_name WHERE name = ms_item-obj_name.
    lv_new = boolc( sy-subrc <> 0 ).
    lv_name = ms_item-obj_name.

    TRY.
        CREATE OBJECT ro_otgr
          EXPORTING
            im_name = lv_name
            im_new  = lv_new.
      CATCH cx_pak_invalid_data
          cx_pak_not_authorized
          cx_pak_invalid_state
          cx_pak_wb_object_locked.
        zcx_abapgit_exception=>raise( |OTGR { lv_name }: error while instantiating CL_CLS_OBJECT_TYPE_GROUP| ).
    ENDTRY.

    IF lv_new = abap_false.
      TRY.
          ro_otgr->if_pak_wb_object~lock_and_refresh( ).
        CATCH cx_pak_invalid_data
            cx_pak_not_authorized
            cx_pak_invalid_state
            cx_pak_wb_object_locked.
          zcx_abapgit_exception=>raise( |OTGR { lv_name }: could not aquire lock| ).
      ENDTRY.
    ENDIF.
  ENDMETHOD.