  PRIVATE SECTION.

    DATA mi_object_oriented_object_fct TYPE REF TO zif_abapgit_oo_object_fnc .

    METHODS serialize_xml
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .