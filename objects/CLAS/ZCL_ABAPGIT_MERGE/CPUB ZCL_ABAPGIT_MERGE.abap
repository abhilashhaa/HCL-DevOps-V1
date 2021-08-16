CLASS zcl_abapgit_merge DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !io_repo          TYPE REF TO zcl_abapgit_repo_online
        !iv_source_branch TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS get_conflicts
      RETURNING
        VALUE(rt_conflicts) TYPE zif_abapgit_definitions=>tt_merge_conflict .
    METHODS get_result
      RETURNING
        VALUE(rs_merge) TYPE zif_abapgit_definitions=>ty_merge .
    METHODS get_source_branch
      RETURNING
        VALUE(rv_source_branch) TYPE string .
    METHODS has_conflicts
      RETURNING
        VALUE(rv_conflicts_exists) TYPE abap_bool .
    METHODS resolve_conflict
      IMPORTING
        !is_conflict TYPE zif_abapgit_definitions=>ty_merge_conflict
      RAISING
        zcx_abapgit_exception .
    METHODS run
      RAISING
        zcx_abapgit_exception .