  PRIVATE SECTION.

    TYPES:
      ty_ancestor_tt TYPE STANDARD TABLE OF zif_abapgit_definitions=>ty_ancestor WITH DEFAULT KEY .
    TYPES:
      ty_visit_tt TYPE STANDARD TABLE OF zif_abapgit_definitions=>ty_sha1 WITH DEFAULT KEY .

    DATA mo_repo TYPE REF TO zcl_abapgit_repo_online .
    DATA ms_merge TYPE zif_abapgit_definitions=>ty_merge .
    DATA mt_conflicts TYPE zif_abapgit_definitions=>tt_merge_conflict .
    DATA mt_objects TYPE zif_abapgit_definitions=>ty_objects_tt .
    DATA mv_source_branch TYPE string .

    METHODS visit
      IMPORTING
        !iv_parent TYPE zif_abapgit_definitions=>ty_sha1
      CHANGING
        !ct_visit  TYPE ty_visit_tt .
    METHODS all_files
      RETURNING
        VALUE(rt_files) TYPE zif_abapgit_definitions=>ty_expanded_tt .
    METHODS calculate_result
      RAISING
        zcx_abapgit_exception .
    METHODS fetch_git
      RETURNING
        VALUE(rt_objects) TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    METHODS find_ancestors
      IMPORTING
        !iv_commit          TYPE zif_abapgit_definitions=>ty_sha1
      RETURNING
        VALUE(rt_ancestors) TYPE ty_ancestor_tt
      RAISING
        zcx_abapgit_exception .
    METHODS find_first_common
      IMPORTING
        !it_list1        TYPE ty_ancestor_tt
        !it_list2        TYPE ty_ancestor_tt
      RETURNING
        VALUE(rs_common) TYPE zif_abapgit_definitions=>ty_ancestor
      RAISING
        zcx_abapgit_exception .