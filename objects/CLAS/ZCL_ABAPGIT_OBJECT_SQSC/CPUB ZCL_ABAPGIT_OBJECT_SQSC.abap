CLASS zcl_abapgit_object_sqsc DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_objects_super
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_object.

    METHODS:
      constructor
        IMPORTING
          is_item     TYPE zif_abapgit_definitions=>ty_item
          iv_language TYPE spras
        RAISING
          zcx_abapgit_exception.
