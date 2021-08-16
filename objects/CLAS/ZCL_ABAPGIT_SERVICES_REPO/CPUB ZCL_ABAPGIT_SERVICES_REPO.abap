CLASS zcl_abapgit_services_repo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS new_online
      IMPORTING
        !is_repo_params TYPE zif_abapgit_services_repo=>ty_repo_params
      RETURNING
        VALUE(ro_repo)  TYPE REF TO zcl_abapgit_repo_online
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS refresh
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS remove
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS purge
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS new_offline
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS remote_attach
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS remote_detach
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS remote_change
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS refresh_local_checksums
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS toggle_favorite
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS transport_to_branch
      IMPORTING
        !iv_repository_key TYPE zif_abapgit_persistence=>ty_value
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS gui_deserialize
      IMPORTING
        !io_repo TYPE REF TO zcl_abapgit_repo
      RAISING
        zcx_abapgit_exception .