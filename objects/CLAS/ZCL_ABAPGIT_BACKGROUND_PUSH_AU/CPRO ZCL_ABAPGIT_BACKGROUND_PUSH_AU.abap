  PROTECTED SECTION.

    DATA mi_log TYPE REF TO zif_abapgit_log .

    METHODS build_comment
      IMPORTING
        !is_files         TYPE zif_abapgit_definitions=>ty_stage_files
      RETURNING
        VALUE(rv_comment) TYPE string .
    METHODS push_auto
      IMPORTING
        !io_repo TYPE REF TO zcl_abapgit_repo_online
      RAISING
        zcx_abapgit_exception .
    METHODS determine_user_details
      IMPORTING
        !iv_changed_by TYPE xubname
      RETURNING
        VALUE(rs_user) TYPE zif_abapgit_definitions=>ty_git_user .
    METHODS push_deletions
      IMPORTING
        !io_repo  TYPE REF TO zcl_abapgit_repo_online
        !is_files TYPE zif_abapgit_definitions=>ty_stage_files
      RAISING
        zcx_abapgit_exception .