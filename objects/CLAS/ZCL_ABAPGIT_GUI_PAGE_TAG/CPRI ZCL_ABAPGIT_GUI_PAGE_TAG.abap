  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_tag_type,
        lightweight TYPE string VALUE 'lightweight',
        annotated   TYPE string VALUE 'annotated',
      END OF c_tag_type .
    DATA mo_repo_online TYPE REF TO zcl_abapgit_repo_online .
    DATA mv_selected_type TYPE string .

    METHODS render_menu
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
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
    METHODS create_tag
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      RAISING
        zcx_abapgit_exception .
    METHODS parse_tag_request
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab
      EXPORTING
        !eg_fields   TYPE any .
    METHODS parse_change_tag_type_request
      IMPORTING
        !it_postdata TYPE cnht_post_data_tab .
    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .