  PRIVATE SECTION.
    DATA:
      mo_stage         TYPE REF TO zcl_abapgit_stage,
      mv_check_variant TYPE sci_chkv.

    METHODS:
      build_menu
        RETURNING
          VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar
        RAISING
          zcx_abapgit_exception,

      run_code_inspector
        RAISING
          zcx_abapgit_exception,

      has_inspection_errors
        RETURNING
          VALUE(rv_has_inspection_errors) TYPE abap_bool,

      is_stage_allowed
        RETURNING
          VALUE(rv_is_stage_allowed) TYPE abap_bool,

      ask_user_for_check_variant
        RETURNING
          VALUE(rv_check_variant) TYPE sci_chkv
        RAISING
          zcx_abapgit_exception,

      determine_check_variant
        RAISING
          zcx_abapgit_exception.