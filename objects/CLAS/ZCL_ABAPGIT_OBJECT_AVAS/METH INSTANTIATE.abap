  METHOD instantiate.

    DATA: lv_id  TYPE guid_32,
          lx_err TYPE REF TO cx_root.

    lv_id = ms_item-obj_name.

    TRY.
        CREATE OBJECT ro_avas
          EXPORTING
            im_assignment_id = lv_id.
      CATCH cx_pak_wb_object_locked INTO lx_err.
        zcx_abapgit_exception=>raise( |AVAS { lv_id }: locked: { lx_err->get_longtext( ) }| ).
      CATCH cx_pak_not_authorized INTO lx_err.
        zcx_abapgit_exception=>raise( |AVAS { lv_id }: not authorized: { lx_err->get_longtext( ) }| ).
      CATCH cx_pak_invalid_state INTO lx_err.
        zcx_abapgit_exception=>raise( |AVAS { lv_id }: invalid state: { lx_err->get_longtext( ) }| ).
      CATCH cx_pak_invalid_data INTO lx_err.
        zcx_abapgit_exception=>raise( |AVAS { lv_id }: invalid data: { lx_err->get_longtext( ) }| ).
    ENDTRY.

  ENDMETHOD.