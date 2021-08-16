  PROTECTED SECTION.

    DATA mt_local TYPE zif_abapgit_definitions=>ty_files_item_tt .
    DATA mt_remote TYPE zif_abapgit_definitions=>ty_files_tt .
    DATA mv_request_local_refresh TYPE abap_bool .
    DATA ms_data TYPE zif_abapgit_persistence=>ty_repo .
    DATA mv_request_remote_refresh TYPE abap_bool .
    DATA mt_status TYPE zif_abapgit_definitions=>ty_results_tt .
    DATA mi_log TYPE REF TO zif_abapgit_log .

    METHODS set_dot_apack
      IMPORTING
        !io_dot_apack TYPE REF TO zcl_abapgit_apack_reader
      RAISING
        zcx_abapgit_exception .
    METHODS set
      IMPORTING
        !it_checksums       TYPE zif_abapgit_persistence=>ty_local_checksum_tt OPTIONAL
        !iv_url             TYPE zif_abapgit_persistence=>ty_repo-url OPTIONAL
        !iv_branch_name     TYPE zif_abapgit_persistence=>ty_repo-branch_name OPTIONAL
        !iv_head_branch     TYPE zif_abapgit_persistence=>ty_repo-head_branch OPTIONAL
        !iv_offline         TYPE zif_abapgit_persistence=>ty_repo-offline OPTIONAL
        !is_dot_abapgit     TYPE zif_abapgit_persistence=>ty_repo-dot_abapgit OPTIONAL
        !is_local_settings  TYPE zif_abapgit_persistence=>ty_repo-local_settings OPTIONAL
        !iv_deserialized_at TYPE zif_abapgit_persistence=>ty_repo-deserialized_at OPTIONAL
        !iv_deserialized_by TYPE zif_abapgit_persistence=>ty_repo-deserialized_by OPTIONAL
        !iv_switched_origin TYPE zif_abapgit_persistence=>ty_repo-switched_origin OPTIONAL
      RAISING
        zcx_abapgit_exception .
    METHODS reset_remote .
