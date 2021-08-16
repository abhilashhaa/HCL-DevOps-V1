CLASS zcl_abapgit_object_tabl_compar DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_comparator .

    METHODS constructor
      IMPORTING
        !ii_local TYPE REF TO zif_abapgit_xml_input.