CLASS zcl_abapgit_apack_reader DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    TYPES ty_package_name TYPE devclass .

    CLASS-METHODS create_instance
      IMPORTING
        !iv_package_name          TYPE ty_package_name
      RETURNING
        VALUE(ro_manifest_reader) TYPE REF TO zcl_abapgit_apack_reader .
    CLASS-METHODS deserialize
      IMPORTING
        !iv_package_name          TYPE ty_package_name
        !iv_xstr                  TYPE xstring
      RETURNING
        VALUE(ro_manifest_reader) TYPE REF TO zcl_abapgit_apack_reader
      RAISING
        zcx_abapgit_exception.
    METHODS get_manifest_descriptor
      RETURNING
        VALUE(rs_manifest_descriptor) TYPE zif_abapgit_apack_definitions=>ty_descriptor
      RAISING
        zcx_abapgit_exception.
    METHODS set_manifest_descriptor
      IMPORTING
        !is_manifest_descriptor TYPE zif_abapgit_apack_definitions=>ty_descriptor
      RAISING
        zcx_abapgit_exception.
    METHODS copy_manifest_descriptor
      IMPORTING
        !io_manifest_provider TYPE REF TO object
      RAISING
        zcx_abapgit_exception.
    METHODS has_manifest
      RETURNING
        VALUE(rv_has_manifest) TYPE abap_bool
      RAISING
        zcx_abapgit_exception.
    METHODS constructor
      IMPORTING
        !iv_package_name TYPE ty_package_name .