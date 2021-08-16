  PRIVATE SECTION.
    CONSTANTS: BEGIN OF c_sortkey,
                 default    TYPE i VALUE 9999,
                 parent_dir TYPE i VALUE 0,
                 dir        TYPE i VALUE 1,
                 orphan     TYPE i VALUE 2,
                 changed    TYPE i VALUE 3,
                 inactive   TYPE i VALUE 4,
               END OF c_sortkey.

    DATA: mo_repo TYPE REF TO zcl_abapgit_repo,
          mi_log  TYPE REF TO zif_abapgit_log.

    METHODS build_repo_items_local_only
      RETURNING VALUE(rt_repo_items) TYPE zif_abapgit_definitions=>tt_repo_items
      RAISING   zcx_abapgit_exception.

    METHODS build_repo_items_with_remote
      RETURNING VALUE(rt_repo_items) TYPE zif_abapgit_definitions=>tt_repo_items
      RAISING   zcx_abapgit_exception.

    METHODS build_folders
      IMPORTING iv_cur_dir    TYPE string
      CHANGING  ct_repo_items TYPE zif_abapgit_definitions=>tt_repo_items
      RAISING   zcx_abapgit_exception.

    METHODS filter_changes
      CHANGING ct_repo_items TYPE zif_abapgit_definitions=>tt_repo_items.