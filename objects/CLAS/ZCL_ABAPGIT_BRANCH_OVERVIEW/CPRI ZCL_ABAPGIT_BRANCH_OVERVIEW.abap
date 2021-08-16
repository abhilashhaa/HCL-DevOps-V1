  PRIVATE SECTION.

    TYPES:
      tyt_commit_sha1_range TYPE RANGE OF zif_abapgit_definitions=>ty_sha1 .

    DATA mt_branches TYPE zif_abapgit_definitions=>ty_git_branch_list_tt .
    DATA mt_commits TYPE zif_abapgit_definitions=>ty_commit_tt .
    DATA mt_tags TYPE zif_abapgit_definitions=>ty_git_tag_list_tt .

    METHODS compress_internal
      IMPORTING
        !iv_name    TYPE string
      CHANGING
        !ct_temp    TYPE zif_abapgit_definitions=>ty_commit_tt
        !ct_commits TYPE zif_abapgit_definitions=>ty_commit_tt .
    CLASS-METHODS parse_commits
      IMPORTING
        !it_objects       TYPE zif_abapgit_definitions=>ty_objects_tt
      RETURNING
        VALUE(rt_commits) TYPE zif_abapgit_definitions=>ty_commit_tt
      RAISING
        zcx_abapgit_exception .
    METHODS parse_annotated_tags
      IMPORTING
        !it_objects TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    METHODS determine_branch
      RAISING
        zcx_abapgit_exception .
    METHODS determine_merges
      RAISING
        zcx_abapgit_exception .
    METHODS fixes
      RAISING
        zcx_abapgit_exception .
    METHODS get_git_objects
      IMPORTING
        !io_repo          TYPE REF TO zcl_abapgit_repo_online
      RETURNING
        VALUE(rt_objects) TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    METHODS determine_tags
      RAISING
        zcx_abapgit_exception .
    METHODS _sort_commits
      CHANGING
        !ct_commits TYPE zif_abapgit_definitions=>ty_commit_tt .
    METHODS _get_1st_child_commit
      IMPORTING
        !it_commit_sha1s TYPE tyt_commit_sha1_range
      EXPORTING
        !et_commit_sha1s TYPE tyt_commit_sha1_range
        !es_1st_commit   TYPE zif_abapgit_definitions=>ty_commit
      CHANGING
        !ct_commits      TYPE zif_abapgit_definitions=>ty_commit_tt .
    METHODS _reverse_sort_order
      CHANGING
        !ct_commits TYPE zif_abapgit_definitions=>ty_commit_tt .