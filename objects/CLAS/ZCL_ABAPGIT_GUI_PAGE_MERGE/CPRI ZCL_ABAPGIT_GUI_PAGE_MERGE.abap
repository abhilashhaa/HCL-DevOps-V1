  PRIVATE SECTION.

    DATA mo_repo TYPE REF TO zcl_abapgit_repo_online .
    DATA mo_merge TYPE REF TO zcl_abapgit_merge .
    CONSTANTS:
      BEGIN OF c_actions,
        merge         TYPE string VALUE 'merge' ##NO_TEXT,
        res_conflicts TYPE string VALUE 'res_conflicts' ##NO_TEXT,
      END OF c_actions .

    METHODS show_file
      IMPORTING
        !it_expanded TYPE zif_abapgit_definitions=>ty_expanded_tt
        !ii_html     TYPE REF TO zif_abapgit_html
        !is_file     TYPE zif_abapgit_definitions=>ty_expanded
        !is_result   TYPE zif_abapgit_definitions=>ty_expanded .
    METHODS build_menu
      IMPORTING
        VALUE(iv_with_conflict) TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(ro_menu)          TYPE REF TO zcl_abapgit_html_toolbar .