  PRIVATE SECTION.
    METHODS:
      serialize_includes
        IMPORTING
          io_class TYPE REF TO cl_enh_tool_class
        RAISING
          zcx_abapgit_exception,
      deserialize_includes
        IMPORTING
          ii_xml   TYPE REF TO zif_abapgit_xml_input
          io_class TYPE REF TO cl_enh_tool_class
        RAISING
          zcx_abapgit_exception.

    DATA: ms_item TYPE zif_abapgit_definitions=>ty_item.
    DATA: mo_files TYPE REF TO zcl_abapgit_objects_files.
