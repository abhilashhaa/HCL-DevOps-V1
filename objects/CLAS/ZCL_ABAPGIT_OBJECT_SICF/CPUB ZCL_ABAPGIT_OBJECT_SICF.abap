CLASS zcl_abapgit_object_sicf DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_objects_super
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_object .

    ALIASES mo_files
      FOR zif_abapgit_object~mo_files .

    TYPES: ty_hash TYPE c LENGTH 25.

    CLASS-METHODS read_tadir_sicf
      IMPORTING
        !iv_pgmid       TYPE tadir-pgmid DEFAULT 'R3TR'
        !iv_obj_name    TYPE tadir-obj_name
      RETURNING
        VALUE(rs_tadir) TYPE zif_abapgit_definitions=>ty_tadir
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS read_sicf_url
      IMPORTING
        !iv_obj_name   TYPE tadir-obj_name
      RETURNING
        VALUE(rv_hash) TYPE ty_hash
      RAISING
        zcx_abapgit_exception .