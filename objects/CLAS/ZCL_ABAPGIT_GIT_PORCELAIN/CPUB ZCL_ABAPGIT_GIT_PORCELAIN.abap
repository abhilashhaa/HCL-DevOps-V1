CLASS zcl_abapgit_git_porcelain DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_pull_result,
        files   TYPE zif_abapgit_definitions=>ty_files_tt,
        objects TYPE zif_abapgit_definitions=>ty_objects_tt,
        branch  TYPE zif_abapgit_definitions=>ty_sha1,
      END OF ty_pull_result .
    TYPES:
      BEGIN OF ty_push_result,
        new_files     TYPE zif_abapgit_definitions=>ty_files_tt,
        branch        TYPE zif_abapgit_definitions=>ty_sha1,
        updated_files TYPE zif_abapgit_definitions=>ty_file_signatures_tt,
        new_objects   TYPE zif_abapgit_definitions=>ty_objects_tt,
      END OF ty_push_result .

    CLASS-METHODS pull
      IMPORTING
        !iv_url          TYPE string
        !iv_branch_name  TYPE string
      RETURNING
        VALUE(rs_result) TYPE ty_pull_result
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS push
      IMPORTING
        !is_comment      TYPE zif_abapgit_definitions=>ty_comment
        !io_stage        TYPE REF TO zcl_abapgit_stage
        !it_old_objects  TYPE zif_abapgit_definitions=>ty_objects_tt
        !iv_parent       TYPE zif_abapgit_definitions=>ty_sha1
        !iv_url          TYPE string
        !iv_branch_name  TYPE string
      RETURNING
        VALUE(rs_result) TYPE ty_push_result
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS create_branch
      IMPORTING
        !iv_url  TYPE string
        !iv_name TYPE string
        !iv_from TYPE zif_abapgit_definitions=>ty_sha1
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS create_tag
      IMPORTING
        !iv_url TYPE string
        !is_tag TYPE zif_abapgit_definitions=>ty_git_tag
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS delete_branch
      IMPORTING
        !iv_url    TYPE string
        !is_branch TYPE zif_abapgit_definitions=>ty_git_branch
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS delete_tag
      IMPORTING
        !iv_url TYPE string
        !is_tag TYPE zif_abapgit_definitions=>ty_git_tag
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS full_tree
      IMPORTING
        !it_objects        TYPE zif_abapgit_definitions=>ty_objects_tt
        !iv_branch         TYPE zif_abapgit_definitions=>ty_sha1
      RETURNING
        VALUE(rt_expanded) TYPE zif_abapgit_definitions=>ty_expanded_tt
      RAISING
        zcx_abapgit_exception .