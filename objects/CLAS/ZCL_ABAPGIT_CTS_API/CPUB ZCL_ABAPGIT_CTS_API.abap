"! Change transport system API
CLASS zcl_abapgit_cts_api DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_abapgit_factory.

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_cts_api.