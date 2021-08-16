CLASS zcl_abapgit_oo_factory DEFINITION PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS:
      make
        IMPORTING
          iv_object_type                   TYPE tadir-object
        RETURNING
          VALUE(ri_object_oriented_object) TYPE REF TO zif_abapgit_oo_object_fnc.