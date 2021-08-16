  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_merge,
        source TYPE string,
        target TYPE string,
      END OF ty_merge .

    DATA mo_repo TYPE REF TO zcl_abapgit_repo_online .
    DATA mv_compress TYPE abap_bool VALUE abap_false ##NO_TEXT.
    DATA mt_commits TYPE zif_abapgit_definitions=>ty_commit_tt .
    DATA mi_branch_overview TYPE REF TO zif_abapgit_branch_overview .
    CONSTANTS:
      BEGIN OF c_actions,
        uncompress TYPE string VALUE 'uncompress' ##NO_TEXT,
        compress   TYPE string VALUE 'compress' ##NO_TEXT,
        refresh    TYPE string VALUE 'refresh' ##NO_TEXT,
        merge      TYPE string VALUE 'merge' ##NO_TEXT,
      END OF c_actions .

    METHODS refresh
      RAISING
        zcx_abapgit_exception .
    METHODS body
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS form_select
      IMPORTING
        !iv_name       TYPE string
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_merge
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS decode_merge
      IMPORTING
        !it_postdata    TYPE cnht_post_data_tab
      RETURNING
        VALUE(rs_merge) TYPE ty_merge
      RAISING
        zcx_abapgit_exception .
    METHODS build_menu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .
    METHODS escape_branch
      IMPORTING
        !iv_string       TYPE string
      RETURNING
        VALUE(rv_string) TYPE string .
    METHODS escape_message
      IMPORTING
        !iv_string       TYPE string
      RETURNING
        VALUE(rv_string) TYPE string .
    METHODS render_commit_popups
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .