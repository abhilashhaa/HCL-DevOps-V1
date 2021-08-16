  PRIVATE SECTION.

    TYPES:
      ty_dd03p_tt TYPE STANDARD TABLE OF dd03p .

    TYPES:
      BEGIN OF ty_dd02_texts,
        ddlanguage TYPE dd02t-ddlanguage,
        ddtext     TYPE dd02t-ddtext,
      END OF ty_dd02_texts,
      tt_dd02_texts TYPE STANDARD TABLE OF ty_dd02_texts.

    CONSTANTS c_longtext_id_tabl TYPE dokil-id VALUE 'TB' ##NO_TEXT.
    CONSTANTS:
      BEGIN OF c_s_dataname,
        segment_definition TYPE string VALUE 'SEGMENT_DEFINITION',
        tabl_extras        TYPE string VALUE 'TABL_EXTRAS',
      END OF c_s_dataname.


    METHODS clear_dd03p_fields
      CHANGING
        !ct_dd03p TYPE ty_dd03p_tt .
    "! Check if structure is an IDoc segment
    "! @parameter rv_is_idoc_segment | It's an IDoc segment or not
    METHODS is_idoc_segment
      RETURNING
        VALUE(rv_is_idoc_segment) TYPE abap_bool.
    METHODS clear_dd03p_fields_common
      CHANGING
        !cs_dd03p TYPE dd03p .
    METHODS clear_dd03p_fields_dataelement
      CHANGING
        !cs_dd03p TYPE dd03p .

    METHODS:
      serialize_texts
        IMPORTING io_xml TYPE REF TO zif_abapgit_xml_output
        RAISING   zcx_abapgit_exception,
      deserialize_texts
        IMPORTING io_xml   TYPE REF TO zif_abapgit_xml_input
                  is_dd02v TYPE dd02v
        RAISING   zcx_abapgit_exception.
