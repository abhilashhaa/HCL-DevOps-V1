CLASS zcl_abapgit_sap_package DEFINITION
    PUBLIC CREATE PRIVATE
    GLOBAL FRIENDS zcl_abapgit_factory.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_package TYPE devclass.

    INTERFACES: zif_abapgit_sap_package.
