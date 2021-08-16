CLASS zcl_abapgit_apack_migration DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CONSTANTS: c_apack_interface_version TYPE i VALUE 1.
    CLASS-METHODS: run RAISING zcx_abapgit_exception.
    METHODS: perform_migration RAISING zcx_abapgit_exception.