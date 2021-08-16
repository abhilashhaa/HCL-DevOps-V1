CLASS zcl_abapgit_git_pack DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_node,
        chmod TYPE zif_abapgit_definitions=>ty_chmod,
        name  TYPE string,
        sha1  TYPE zif_abapgit_definitions=>ty_sha1,
      END OF ty_node .
    TYPES:
      ty_nodes_tt TYPE STANDARD TABLE OF ty_node WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_commit,
        tree      TYPE zif_abapgit_definitions=>ty_sha1,
        parent    TYPE zif_abapgit_definitions=>ty_sha1,
        parent2   TYPE zif_abapgit_definitions=>ty_sha1,
        author    TYPE string,
        committer TYPE string,
        gpgsig    TYPE string,
        body      TYPE string,
      END OF ty_commit .
    TYPES:
      BEGIN OF ty_tag,
        object       TYPE string,
        type         TYPE string,
        tag          TYPE string,
        tagger_name  TYPE string,
        tagger_email TYPE string,
        message      TYPE string,
        body         TYPE string,
      END OF ty_tag .

    CLASS-METHODS decode
      IMPORTING
        !iv_data          TYPE xstring
      RETURNING
        VALUE(rt_objects) TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS decode_tree
      IMPORTING
        !iv_data        TYPE xstring
      RETURNING
        VALUE(rt_nodes) TYPE ty_nodes_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS decode_commit
      IMPORTING
        !iv_data         TYPE xstring
      RETURNING
        VALUE(rs_commit) TYPE ty_commit
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS decode_tag
      IMPORTING
        !iv_data      TYPE xstring
      RETURNING
        VALUE(rs_tag) TYPE ty_tag
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS encode
      IMPORTING
        !it_objects    TYPE zif_abapgit_definitions=>ty_objects_tt
      RETURNING
        VALUE(rv_data) TYPE xstring
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS encode_tree
      IMPORTING
        !it_nodes      TYPE ty_nodes_tt
      RETURNING
        VALUE(rv_data) TYPE xstring .
    CLASS-METHODS encode_commit
      IMPORTING
        !is_commit     TYPE ty_commit
      RETURNING
        VALUE(rv_data) TYPE xstring .
    CLASS-METHODS encode_tag
      IMPORTING
        !is_tag        TYPE ty_tag
      RETURNING
        VALUE(rv_data) TYPE xstring
      RAISING
        zcx_abapgit_exception .