CLASS zcl_abapgit_object_dsys DEFINITION PUBLIC INHERITING FROM zcl_abapgit_objects_super FINAL.

  PUBLIC SECTION.

    INTERFACES zif_abapgit_object.

    METHODS constructor
      IMPORTING
        is_item     TYPE zif_abapgit_definitions=>ty_item
        iv_language TYPE spras.
