CLASS zcl_abapgit_oo_class DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_oo_base
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS zif_abapgit_oo_object_fnc~create
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~create_sotr
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~delete
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~generate_locals
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~get_class_properties
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~get_includes
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~insert_text_pool
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~read_sotr
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~read_text_pool
        REDEFINITION .
    METHODS zif_abapgit_oo_object_fnc~deserialize_source
        REDEFINITION .