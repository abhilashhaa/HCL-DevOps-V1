  PROTECTED SECTION.

    CONSTANTS:
      BEGIN OF c_actions,
        rerun  TYPE string VALUE 'rerun' ##NO_TEXT,
        sort_1 TYPE string VALUE 'sort_1'  ##NO_TEXT,
        sort_2 TYPE string VALUE 'sort_2'  ##NO_TEXT,
        sort_3 TYPE string VALUE 'sort_3'  ##NO_TEXT,
        stage  TYPE string VALUE 'stage' ##NO_TEXT,
        commit TYPE string VALUE 'commit' ##NO_TEXT,
      END OF c_actions .
    DATA mo_repo TYPE REF TO zcl_abapgit_repo .
    DATA mt_result TYPE scit_alvlist .

    METHODS render_variant
      IMPORTING
        !iv_variant    TYPE sci_chkv
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .
    METHODS render_result
      IMPORTING
        !ii_html   TYPE REF TO zif_abapgit_html
        !it_result TYPE scit_alvlist .
    METHODS render_result_line
      IMPORTING
        !ii_html   TYPE REF TO zif_abapgit_html
        !is_result TYPE scir_alvlist .
    METHODS build_nav_link
      IMPORTING
        !is_result     TYPE scir_alvlist
      RETURNING
        VALUE(rv_link) TYPE string .
    METHODS jump
      IMPORTING
        !is_item        TYPE zif_abapgit_definitions=>ty_item
        !is_sub_item    TYPE zif_abapgit_definitions=>ty_item
        !iv_line_number TYPE i
      RAISING
        zcx_abapgit_exception .
    METHODS build_base_menu
      RETURNING
        VALUE(ro_menu) TYPE REF TO zcl_abapgit_html_toolbar .