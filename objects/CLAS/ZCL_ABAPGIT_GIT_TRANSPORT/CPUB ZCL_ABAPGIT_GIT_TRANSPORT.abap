CLASS zcl_abapgit_git_transport DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* remote to local
    CLASS-METHODS upload_pack_by_branch
      IMPORTING
        !iv_url          TYPE string
        !iv_branch_name  TYPE string
        !iv_deepen_level TYPE i DEFAULT 1
        !it_branches     TYPE zif_abapgit_definitions=>ty_git_branch_list_tt OPTIONAL
      EXPORTING
        !et_objects      TYPE zif_abapgit_definitions=>ty_objects_tt
        !ev_branch       TYPE zif_abapgit_definitions=>ty_sha1
        !eo_branch_list  TYPE REF TO zcl_abapgit_git_branch_list
      RAISING
        zcx_abapgit_exception .
* local to remote
    CLASS-METHODS receive_pack
      IMPORTING
        !iv_url         TYPE string
        !iv_old         TYPE zif_abapgit_definitions=>ty_sha1
        !iv_new         TYPE zif_abapgit_definitions=>ty_sha1
        !iv_branch_name TYPE string
        !iv_pack        TYPE xstring
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS branches
      IMPORTING
        !iv_url               TYPE string
      RETURNING
        VALUE(ro_branch_list) TYPE REF TO zcl_abapgit_git_branch_list
      RAISING
        zcx_abapgit_exception .