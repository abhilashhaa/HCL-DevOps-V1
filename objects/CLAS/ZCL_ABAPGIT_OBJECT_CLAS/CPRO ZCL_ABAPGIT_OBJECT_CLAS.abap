  PROTECTED SECTION.
    DATA: mi_object_oriented_object_fct TYPE REF TO zif_abapgit_oo_object_fnc,
          mv_skip_testclass             TYPE abap_bool,
          mv_classpool_name             TYPE progname.
    METHODS:
      deserialize_abap
        IMPORTING ii_xml     TYPE REF TO zif_abapgit_xml_input
                  iv_package TYPE devclass
        RAISING   zcx_abapgit_exception,
      deserialize_docu
        IMPORTING ii_xml TYPE REF TO zif_abapgit_xml_input
        RAISING   zcx_abapgit_exception,
      deserialize_tpool
        IMPORTING ii_xml TYPE REF TO zif_abapgit_xml_input
        RAISING   zcx_abapgit_exception,
      deserialize_sotr
        IMPORTING ii_ml     TYPE REF TO zif_abapgit_xml_input
                  iv_package TYPE devclass
        RAISING   zcx_abapgit_exception,
      serialize_xml
        IMPORTING ii_xml TYPE REF TO zif_abapgit_xml_output
        RAISING   zcx_abapgit_exception,
      serialize_attr
        IMPORTING
          !ii_xml     TYPE REF TO zif_abapgit_xml_output
          !iv_clsname TYPE seoclsname
        RAISING
          zcx_abapgit_exception,
      serialize_descr
        IMPORTING
          !ii_xml     TYPE REF TO zif_abapgit_xml_output
          !iv_clsname TYPE seoclsname
        RAISING
          zcx_abapgit_exception,
      serialize_docu
        IMPORTING
          !ii_xml              TYPE REF TO zif_abapgit_xml_output
          !it_langu_additional TYPE zif_abapgit_lang_definitions=>tt_langu OPTIONAL
          !iv_clsname          TYPE seoclsname
        RAISING
          zcx_abapgit_exception,
      serialize_tpool
        IMPORTING
          !ii_xml              TYPE REF TO zif_abapgit_xml_output
          !it_langu_additional TYPE zif_abapgit_lang_definitions=>tt_langu OPTIONAL
          !iv_clsname          TYPE seoclsname
        RAISING
          zcx_abapgit_exception,
      serialize_sotr
        IMPORTING
          !ii_xml TYPE REF TO zif_abapgit_xml_output
        RAISING
          zcx_abapgit_exception,
      source_apack_replacement
        CHANGING
          !ct_source TYPE seop_source_string
        RAISING
          zcx_abapgit_exception,
      repo_apack_replacement
        CHANGING
          !ct_source TYPE seop_source_string
        RAISING
          zcx_abapgit_exception.
