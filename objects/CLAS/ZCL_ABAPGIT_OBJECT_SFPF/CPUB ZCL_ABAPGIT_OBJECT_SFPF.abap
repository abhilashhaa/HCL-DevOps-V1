CLASS zcl_abapgit_object_sfpf DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_objects_super
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_object .

    ALIASES mo_files
      FOR zif_abapgit_object~mo_files .

    CLASS-METHODS fix_oref
      IMPORTING
        !ii_document TYPE REF TO if_ixml_document
      RAISING
        zcx_abapgit_exception .