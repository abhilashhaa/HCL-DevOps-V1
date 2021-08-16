  PRIVATE SECTION.
    METHODS:
      build_menu
        RETURNING
          VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar
        RAISING
          zcx_abapgit_exception,

      run_syntax_check
        RAISING
          zcx_abapgit_exception.