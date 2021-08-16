  PRIVATE SECTION.

    CONSTANTS: c_typ TYPE dokhl-typ VALUE 'E',
               c_id  TYPE dokhl-id VALUE 'HY'.

    DATA: mv_doc_object  TYPE sobj_name.

    TYPES: BEGIN OF ty_data,
             doctitle TYPE dsyst-doktitle,
             head     TYPE thead,
             lines    TYPE tline_tab,
           END OF ty_data.

    METHODS deserialize_dsys
      IMPORTING
        ii_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception.

    METHODS get_master_lang
      RETURNING
        VALUE(rv_language) TYPE spras.
