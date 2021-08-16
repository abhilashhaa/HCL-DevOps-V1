  PRIVATE SECTION.

    TYPES:
        " You are reminded that the text serialisation / de-serialisation methods depend upon a common type.
        " To make the dependency explicit, there is one common definition.
      BEGIN OF ty_udmo_text_type.
    TYPES sprache TYPE dm40t-sprache.
    TYPES dmoid TYPE dm40t-dmoid.
    TYPES langbez TYPE dm40t-langbez.
    TYPES as4local TYPE dm40t-as4local.
    TYPES END OF ty_udmo_text_type .

    DATA mv_data_model TYPE uddmodl .
    DATA mv_text_object TYPE doku_obj .
    DATA mv_lxe_text_name TYPE lxeobjname .
    DATA mv_activation_state TYPE as4local .
    DATA ms_object_type TYPE rsdeo .
    CONSTANTS c_transport_object_class TYPE trobjtype VALUE 'SUDM' ##NO_TEXT.
    CONSTANTS c_lxe_text_type TYPE lxeobjtype VALUE 'IM' ##NO_TEXT.
    CONSTANTS c_correction_object_type TYPE rsdeo-objtype VALUE 'UDMO' ##NO_TEXT.
    CONSTANTS c_active_state TYPE as4local VALUE 'A' ##NO_TEXT.

    METHODS is_name_permitted
      RAISING
        zcx_abapgit_exception .
    METHODS update_tree .
    METHODS serialize_short_texts
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_short_texts
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_long_texts
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_long_texts
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_entities
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_entities
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS access_modify
      RETURNING
        VALUE(rv_result) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS access_free
      RETURNING
        VALUE(rv_result) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_model
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_model
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .