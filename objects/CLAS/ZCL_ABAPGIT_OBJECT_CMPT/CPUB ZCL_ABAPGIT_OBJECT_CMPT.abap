CLASS zcl_abapgit_object_cmpt DEFINITION PUBLIC INHERITING FROM zcl_abapgit_objects_super FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          is_item     TYPE zif_abapgit_definitions=>ty_item
          iv_language TYPE spras.

    INTERFACES zif_abapgit_object.
