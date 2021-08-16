CLASS zcl_abapgit_repo_online DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_repo
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_git_operations .

    ALIASES create_branch
      FOR zif_abapgit_git_operations~create_branch .
    ALIASES push
      FOR zif_abapgit_git_operations~push .

    METHODS get_url
      RETURNING
        VALUE(rv_url) TYPE zif_abapgit_persistence=>ty_repo-url .
    METHODS get_branch_name
      RETURNING
        VALUE(rv_name) TYPE zif_abapgit_persistence=>ty_repo-branch_name .
    METHODS set_url
      IMPORTING
        !iv_url TYPE zif_abapgit_persistence=>ty_repo-url
      RAISING
        zcx_abapgit_exception .
    METHODS set_branch_name
      IMPORTING
        !iv_branch_name TYPE zif_abapgit_persistence=>ty_repo-branch_name
      RAISING
        zcx_abapgit_exception .
    METHODS get_sha1_remote
      RETURNING
        VALUE(rv_sha1) TYPE zif_abapgit_definitions=>ty_sha1
      RAISING
        zcx_abapgit_exception .
    METHODS get_objects
      RETURNING
        VALUE(rt_objects) TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    METHODS get_commit_display_url
      IMPORTING
        !iv_hash      TYPE zif_abapgit_definitions=>ty_sha1
      RETURNING
        VALUE(rv_url) TYPE zif_abapgit_persistence=>ty_repo-url
      RAISING
        zcx_abapgit_exception .
    METHODS get_switched_origin
      RETURNING
        VALUE(rv_url) TYPE zif_abapgit_persistence=>ty_repo-switched_origin .
    METHODS switch_origin
      IMPORTING
        !iv_url       TYPE zif_abapgit_persistence=>ty_repo-url
        !iv_overwrite TYPE abap_bool DEFAULT abap_false
      RAISING
        zcx_abapgit_exception .

    METHODS get_files_remote
        REDEFINITION .
    METHODS get_name
        REDEFINITION .
    METHODS has_remote_source
        REDEFINITION .
    METHODS rebuild_local_checksums
        REDEFINITION .