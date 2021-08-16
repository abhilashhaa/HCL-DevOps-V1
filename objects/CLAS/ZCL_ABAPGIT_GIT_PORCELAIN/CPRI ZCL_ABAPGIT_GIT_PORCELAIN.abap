  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_tree,
        path TYPE string,
        data TYPE xstring,
        sha1 TYPE zif_abapgit_definitions=>ty_sha1,
      END OF ty_tree .
    TYPES:
      ty_trees_tt TYPE STANDARD TABLE OF ty_tree WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_folder,
        path  TYPE string,
        count TYPE i,
        sha1  TYPE zif_abapgit_definitions=>ty_sha1,
      END OF ty_folder .
    TYPES:
      ty_folders_tt TYPE STANDARD TABLE OF ty_folder WITH DEFAULT KEY .

    CONSTANTS c_zero TYPE zif_abapgit_definitions=>ty_sha1 VALUE '0000000000000000000000000000000000000000' ##NO_TEXT.

    CLASS-METHODS build_trees
      IMPORTING
        !it_expanded    TYPE zif_abapgit_definitions=>ty_expanded_tt
      RETURNING
        VALUE(rt_trees) TYPE ty_trees_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS find_folders
      IMPORTING
        !it_expanded      TYPE zif_abapgit_definitions=>ty_expanded_tt
      RETURNING
        VALUE(rt_folders) TYPE ty_folders_tt .
    CLASS-METHODS walk
      IMPORTING
        !it_objects TYPE zif_abapgit_definitions=>ty_objects_tt
        !iv_sha1    TYPE zif_abapgit_definitions=>ty_sha1
        !iv_path    TYPE string
      CHANGING
        !ct_files   TYPE zif_abapgit_definitions=>ty_files_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS walk_tree
      IMPORTING
        !it_objects        TYPE zif_abapgit_definitions=>ty_objects_tt
        !iv_tree           TYPE zif_abapgit_definitions=>ty_sha1
        !iv_base           TYPE string
      RETURNING
        VALUE(rt_expanded) TYPE zif_abapgit_definitions=>ty_expanded_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS receive_pack_push
      IMPORTING
        !is_comment     TYPE zif_abapgit_definitions=>ty_comment
        !it_trees       TYPE ty_trees_tt
        !it_blobs       TYPE zif_abapgit_definitions=>ty_files_tt
        !iv_parent      TYPE zif_abapgit_definitions=>ty_sha1
        !iv_parent2     TYPE zif_abapgit_definitions=>ty_sha1 OPTIONAL
        !iv_url         TYPE string
        !iv_branch_name TYPE string
      EXPORTING
        !ev_new_commit  TYPE zif_abapgit_definitions=>ty_sha1
        !et_new_objects TYPE zif_abapgit_definitions=>ty_objects_tt
        !ev_new_tree    TYPE zif_abapgit_definitions=>ty_sha1
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS receive_pack_create_tag
      IMPORTING
        !is_tag TYPE zif_abapgit_definitions=>ty_git_tag
        !iv_url TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS create_annotated_tag
      IMPORTING
        !is_tag TYPE zif_abapgit_definitions=>ty_git_tag
        !iv_url TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS create_lightweight_tag
      IMPORTING
        !is_tag TYPE zif_abapgit_definitions=>ty_git_tag
        !iv_url TYPE string
      RAISING
        zcx_abapgit_exception .