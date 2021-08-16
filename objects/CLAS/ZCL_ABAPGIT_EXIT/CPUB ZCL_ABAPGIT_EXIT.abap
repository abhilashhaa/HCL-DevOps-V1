CLASS zcl_abapgit_exit DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS: get_instance RETURNING VALUE(ri_exit) TYPE REF TO zif_abapgit_exit.

    INTERFACES: zif_abapgit_exit.
