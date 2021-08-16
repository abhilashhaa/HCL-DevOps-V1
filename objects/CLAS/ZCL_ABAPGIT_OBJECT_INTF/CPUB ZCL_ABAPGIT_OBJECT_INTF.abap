CLASS zcl_abapgit_object_intf DEFINITION PUBLIC FINAL INHERITING FROM zcl_abapgit_objects_program.
  PUBLIC SECTION.
    INTERFACES zif_abapgit_object.
    ALIASES mo_files FOR zif_abapgit_object~mo_files.
    METHODS constructor
      IMPORTING
        is_item     TYPE zif_abapgit_definitions=>ty_item
        iv_language TYPE spras.