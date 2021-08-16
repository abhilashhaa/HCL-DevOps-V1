  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF c_actions,
        show         TYPE string VALUE 'show' ##NO_TEXT,
        overview     TYPE string VALUE 'overview',
        select       TYPE string VALUE 'select',
        apply_filter TYPE string VALUE 'apply_filter',
        abapgit_home TYPE string VALUE 'abapgit_home',
      END OF c_actions.

    DATA: mo_repo_overview TYPE REF TO zcl_abapgit_gui_repo_over,
          mv_repo_key      TYPE zif_abapgit_persistence=>ty_value.

    METHODS build_main_menu
      RETURNING VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar.
