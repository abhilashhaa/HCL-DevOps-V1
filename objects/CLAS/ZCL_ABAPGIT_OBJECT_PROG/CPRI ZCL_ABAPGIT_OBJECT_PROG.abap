  PRIVATE SECTION.
    TYPES: BEGIN OF ty_tpool_i18n,
             language TYPE langu,
             textpool TYPE zif_abapgit_definitions=>ty_tpool_tt,
           END OF ty_tpool_i18n,
           tt_tpool_i18n TYPE STANDARD TABLE OF ty_tpool_i18n.
    CONSTANTS: c_longtext_id_prog TYPE dokil-id VALUE 'RE'.

    METHODS:
      serialize_texts
        IMPORTING ii_xml TYPE REF TO zif_abapgit_xml_output
        RAISING   zcx_abapgit_exception,
      deserialize_texts
        IMPORTING ii_xml TYPE REF TO zif_abapgit_xml_input
        RAISING   zcx_abapgit_exception,
      is_program_locked
        RETURNING
          VALUE(rv_is_program_locked) TYPE abap_bool
        RAISING
          zcx_abapgit_exception.
