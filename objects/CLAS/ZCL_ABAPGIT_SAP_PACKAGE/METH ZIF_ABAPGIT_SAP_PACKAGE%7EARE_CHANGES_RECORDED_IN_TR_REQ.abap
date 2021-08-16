  METHOD zif_abapgit_sap_package~are_changes_recorded_in_tr_req.

    DATA: li_package TYPE REF TO if_package.

    cl_package_factory=>load_package(
      EXPORTING
        i_package_name             = mv_package
      IMPORTING
        e_package                  = li_package
      EXCEPTIONS
        object_not_existing        = 1
        unexpected_error           = 2
        intern_err                 = 3
        no_access                  = 4
        object_locked_and_modified = 5
        OTHERS                     = 6 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from CL_PACKAGE_FACTORY=>LOAD_PACKAGE { sy-subrc }| ).
    ENDIF.

    rv_are_changes_rec_in_tr_req = li_package->wbo_korr_flag.

  ENDMETHOD.