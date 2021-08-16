  PROTECTED SECTION.
    DATA: mi_ixml     TYPE REF TO if_ixml,
          mi_xml_doc  TYPE REF TO if_ixml_document,
          ms_metadata TYPE zif_abapgit_definitions=>ty_metadata,
          mv_filename TYPE string.

    CONSTANTS: c_abapgit_tag             TYPE string VALUE 'abapGit' ##NO_TEXT,
               c_attr_version            TYPE string VALUE 'version' ##NO_TEXT,
               c_attr_serializer         TYPE string VALUE 'serializer' ##NO_TEXT,
               c_attr_serializer_version TYPE string VALUE 'serializer_version' ##NO_TEXT.

    METHODS to_xml
      IMPORTING iv_normalize  TYPE abap_bool DEFAULT abap_true
      RETURNING VALUE(rv_xml) TYPE string.

    METHODS parse
      IMPORTING iv_xml TYPE string
      RAISING   zcx_abapgit_exception.