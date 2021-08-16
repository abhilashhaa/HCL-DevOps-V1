  PRIVATE SECTION.

    DATA mo_repo TYPE REF TO zcl_abapgit_repo_online .
    DATA mo_stage TYPE REF TO zcl_abapgit_stage .
    DATA ms_commit TYPE zif_abapgit_services_git=>ty_commit_fields .

    METHODS render_menu
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_stage
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_form
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_text_input
      IMPORTING
        !iv_name       TYPE string
        !iv_label      TYPE string
        !iv_value      TYPE string OPTIONAL
        !iv_max_length TYPE string OPTIONAL
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS get_comment_default
      RETURNING
        VALUE(rv_text) TYPE string .
    METHODS get_comment_object
      IMPORTING
        !it_stage      TYPE zif_abapgit_definitions=>ty_stage_tt
      RETURNING
        VALUE(rv_text) TYPE string .
    METHODS get_comment_file
      IMPORTING
        !it_stage      TYPE zif_abapgit_definitions=>ty_stage_tt
      RETURNING
        VALUE(rv_text) TYPE string .
    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .