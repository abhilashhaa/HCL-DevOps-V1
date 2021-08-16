  PROTECTED SECTION.

    CONSTANTS:
      BEGIN OF c_action,
        save_settings TYPE string VALUE 'save_settings',
      END OF c_action .
    DATA mo_repo TYPE REF TO zcl_abapgit_repo.

    METHODS render_dot_abapgit
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html .
    METHODS render_local_settings
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_remotes
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS save
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      RAISING
        zcx_abapgit_exception .
    METHODS save_dot_abap
      IMPORTING
        !it_post_fields TYPE tihttpnvp
      RAISING
        zcx_abapgit_exception .
    METHODS save_local_settings
      IMPORTING
        !it_post_fields TYPE tihttpnvp
      RAISING
        zcx_abapgit_exception .
    METHODS save_remotes
      IMPORTING
        !it_post_fields TYPE tihttpnvp
      RAISING
        zcx_abapgit_exception .
    METHODS render_dot_abapgit_reqs
      IMPORTING
        ii_html         TYPE REF TO zif_abapgit_html
        it_requirements TYPE zif_abapgit_dot_abapgit=>ty_requirement_tt.
    METHODS render_table_row
      IMPORTING
        iv_name        TYPE string
        iv_value       TYPE string
      RETURNING
        VALUE(rv_html) TYPE string.


    METHODS render_content
        REDEFINITION .
