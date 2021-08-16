  METHOD zif_abapgit_object~exists.

    DATA: lv_name TYPE wdy_application_name.


    lv_name = ms_item-obj_name.

    TRY.
        cl_wdy_md_application=>get_object_by_key(
          name    = lv_name
          version = 'A' ).
        rv_bool = abap_true.
      CATCH cx_wdy_md_not_existing.
        rv_bool = abap_false.
      CATCH cx_wdy_md_permission_failure.
        zcx_abapgit_exception=>raise( 'WDYA, permission failure' ).
    ENDTRY.

  ENDMETHOD.