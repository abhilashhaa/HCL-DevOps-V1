CLASS zcl_abapgit_git_branch_list DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        !iv_data TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS find_by_name
      IMPORTING
        !iv_branch_name  TYPE clike
      RETURNING
        VALUE(rs_branch) TYPE zif_abapgit_definitions=>ty_git_branch
      RAISING
        zcx_abapgit_exception .
    METHODS get_head_symref
      RETURNING
        VALUE(rv_head_symref) TYPE string .
    METHODS get_all
      RETURNING
        VALUE(rt_branches) TYPE zif_abapgit_definitions=>ty_git_branch_list_tt
      RAISING
        zcx_abapgit_exception .
    METHODS get_branches_only
      RETURNING
        VALUE(rt_branches) TYPE zif_abapgit_definitions=>ty_git_branch_list_tt
      RAISING
        zcx_abapgit_exception .
    METHODS get_tags_only             " For potential future use
      RETURNING
        VALUE(rt_tags) TYPE zif_abapgit_definitions=>ty_git_branch_list_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_display_name
      IMPORTING
        !iv_branch_name        TYPE clike
      RETURNING
        VALUE(rv_display_name) TYPE string .
    CLASS-METHODS get_type
      IMPORTING
        !iv_branch_name       TYPE clike
        !it_result            TYPE string_table OPTIONAL
        !iv_current_row_index TYPE sy-tabix OPTIONAL
      RETURNING
        VALUE(rv_type)        TYPE zif_abapgit_definitions=>ty_git_branch_type .
    CLASS-METHODS complete_heads_branch_name
      IMPORTING
        !iv_branch_name TYPE clike
      RETURNING
        VALUE(rv_name)  TYPE string .
    CLASS-METHODS normalize_branch_name
      IMPORTING
        !iv_branch_name TYPE clike
      RETURNING
        VALUE(rv_name)  TYPE string .