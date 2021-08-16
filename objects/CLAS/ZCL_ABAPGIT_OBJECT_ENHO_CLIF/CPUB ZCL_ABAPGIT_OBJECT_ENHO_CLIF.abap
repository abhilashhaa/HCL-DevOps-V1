CLASS zcl_abapgit_object_enho_clif DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS deserialize
      IMPORTING
        !io_xml  TYPE REF TO zif_abapgit_xml_input
        !io_clif TYPE REF TO cl_enh_tool_clif
      RAISING
        zcx_abapgit_exception
        cx_enh_root .
    CLASS-METHODS serialize
      IMPORTING
        !io_xml   TYPE REF TO zif_abapgit_xml_output
        !io_files TYPE REF TO zcl_abapgit_objects_files
        !io_clif  TYPE REF TO cl_enh_tool_clif
      RAISING
        zcx_abapgit_exception .