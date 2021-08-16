CLASS zcl_abapgit_ajson DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS ported_from_url TYPE string VALUE 'https://github.com/sbcgua/ajson'.

    INTERFACES zif_abapgit_ajson_reader .

    TYPES:
      BEGIN OF ty_node,
        path     TYPE string,
        name     TYPE string,
        type     TYPE string,
        value    TYPE string,
        index    TYPE i,
        children TYPE i,
      END OF ty_node .
    TYPES:
      ty_nodes_tt TYPE STANDARD TABLE OF ty_node WITH KEY path name .
    TYPES:
      ty_nodes_ts TYPE SORTED TABLE OF ty_node
        WITH UNIQUE KEY path name
        WITH NON-UNIQUE SORTED KEY array_index COMPONENTS path index .
    TYPES:
      BEGIN OF ty_path_name,
        path TYPE string,
        name TYPE string,
      END OF ty_path_name.

    CLASS-METHODS parse
      IMPORTING
        !iv_json           TYPE string
        !iv_freeze         TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(ro_instance) TYPE REF TO zcl_abapgit_ajson
      RAISING
        zcx_abapgit_ajson_error .

    METHODS freeze.
