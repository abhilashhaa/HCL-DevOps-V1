  METHOD update_meta.

    DATA: lo_update     TYPE REF TO cl_oo_class_section_source,
          ls_clskey     TYPE seoclskey,
          lv_scan_error TYPE abap_bool.


    ls_clskey-clsname = iv_name.

    TRY.
        CALL FUNCTION 'SEO_BUFFER_REFRESH'
          EXPORTING
            cifkey  = ls_clskey
            version = seoc_version_active.
        CREATE OBJECT lo_update TYPE ('CL_OO_CLASS_SECTION_SOURCE')
          EXPORTING
            clskey                        = ls_clskey
            exposure                      = iv_exposure
            state                         = 'A'
            source                        = it_source
            suppress_constrctr_generation = abap_true
          EXCEPTIONS
            class_not_existing            = 1
            read_source_error             = 2
            OTHERS                        = 3 ##SUBRC_OK.
      CATCH cx_sy_dyn_call_param_not_found.
* downport to 702, see https://github.com/abapGit/abapGit/issues/933
* this will READ REPORT instead of using it_source, which should be okay
        CREATE OBJECT lo_update TYPE cl_oo_class_section_source
          EXPORTING
            clskey             = ls_clskey
            exposure           = iv_exposure
            state              = 'A'
          EXCEPTIONS
            class_not_existing = 1
            read_source_error  = 2
            OTHERS             = 3.
    ENDTRY.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error instantiating CL_OO_CLASS_SECTION_SOURCE. Subrc = { sy-subrc }| ).
    ENDIF.

    lo_update->set_dark_mode( abap_true ).
    TRY.
        CALL METHOD lo_update->('SET_AMDP_SUPPORT')
          EXPORTING
            enabled = abap_true.
      CATCH cx_sy_dyn_call_illegal_method ##NO_HANDLER.
* AMDP not supported in this system, ignore error
    ENDTRY.
    lo_update->scan_section_source(
      RECEIVING
        scan_error             = lv_scan_error
      EXCEPTIONS
        scan_abap_source_error = 1
        OTHERS                 = 2 ).
    IF sy-subrc <> 0 OR lv_scan_error = abap_true.
      zcx_abapgit_exception=>raise( |CLAS, error while scanning source. Subrc = { sy-subrc }| ).
    ENDIF.

* this will update the SEO* database tables
    lo_update->revert_scan_result( ).

    IF iv_exposure = seoc_exposure_public.
      generate_classpool( iv_name ).
    ENDIF.

  ENDMETHOD.