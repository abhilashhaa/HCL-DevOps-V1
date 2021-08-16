CLASS zcl_abapgit_services_git DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS pull
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS reset
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS create_branch
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS switch_branch
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS delete_branch
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.

    CLASS-METHODS delete_tag
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS switch_tag
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS tag_overview
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS commit
      IMPORTING
        !io_repo   TYPE REF TO zcl_abapgit_repo_online
        !is_commit TYPE zif_abapgit_services_git=>ty_commit_fields
        !io_stage  TYPE REF TO zcl_abapgit_stage
      RAISING
        zcx_abapgit_exception.