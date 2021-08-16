CLASS zcl_abapgit_objects_bridge DEFINITION PUBLIC FINAL CREATE PUBLIC INHERITING FROM zcl_abapgit_objects_super.

  PUBLIC SECTION.

    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING is_item TYPE zif_abapgit_definitions=>ty_item
      RAISING   cx_sy_create_object_error.

    INTERFACES zif_abapgit_object.
    ALIASES mo_files FOR zif_abapgit_object~mo_files.
