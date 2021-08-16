CLASS zcl_abapgit_object_enho_hook DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS: constructor
      IMPORTING
        is_item  TYPE zif_abapgit_definitions=>ty_item
        io_files TYPE REF TO zcl_abapgit_objects_files.

    INTERFACES: zif_abapgit_object_enho.
