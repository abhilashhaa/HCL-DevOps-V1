  PRIVATE SECTION.

    DATA mt_branches TYPE zif_abapgit_definitions=>ty_git_branch_list_tt .
    DATA mv_head_symref TYPE string .

    CLASS-METHODS skip_first_pkt
      IMPORTING
        !iv_data       TYPE string
      RETURNING
        VALUE(rv_data) TYPE string .
    METHODS find_tag_by_name
      IMPORTING
        !iv_branch_name  TYPE string
      RETURNING
        VALUE(rs_branch) TYPE zif_abapgit_definitions=>ty_git_branch
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS parse_branch_list
      IMPORTING
        !iv_data        TYPE string
      EXPORTING
        !et_list        TYPE zif_abapgit_definitions=>ty_git_branch_list_tt
        !ev_head_symref TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS parse_head_params
      IMPORTING
        !iv_data              TYPE string
      RETURNING
        VALUE(rv_head_symref) TYPE string .