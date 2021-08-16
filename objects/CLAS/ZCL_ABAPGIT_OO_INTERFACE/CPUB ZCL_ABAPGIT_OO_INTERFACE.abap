CLASS zcl_abapgit_oo_interface DEFINITION PUBLIC
  INHERITING FROM zcl_abapgit_oo_base.
  PUBLIC SECTION.
    METHODS:
      zif_abapgit_oo_object_fnc~create REDEFINITION,
      zif_abapgit_oo_object_fnc~get_includes REDEFINITION,
      zif_abapgit_oo_object_fnc~get_interface_properties REDEFINITION,
      zif_abapgit_oo_object_fnc~delete REDEFINITION.