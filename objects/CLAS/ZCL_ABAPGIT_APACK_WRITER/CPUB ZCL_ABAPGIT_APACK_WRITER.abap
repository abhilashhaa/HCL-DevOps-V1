CLASS zcl_abapgit_apack_writer DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS create_instance
      IMPORTING
        !is_apack_manifest_descriptor TYPE zif_abapgit_apack_definitions=>ty_descriptor
      RETURNING
        VALUE(ro_manifest_writer)     TYPE REF TO zcl_abapgit_apack_writer .
    METHODS serialize
      RETURNING
        VALUE(rv_xml) TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS constructor
      IMPORTING
        !is_apack_manifest_descriptor TYPE zif_abapgit_apack_definitions=>ty_descriptor .