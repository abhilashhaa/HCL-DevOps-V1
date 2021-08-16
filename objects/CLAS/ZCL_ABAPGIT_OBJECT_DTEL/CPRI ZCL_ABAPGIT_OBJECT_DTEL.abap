  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_dd04_texts,
        ddlanguage TYPE dd04t-ddlanguage,
        ddtext     TYPE dd04t-ddtext,
        reptext    TYPE dd04t-reptext,
        scrtext_s  TYPE dd04t-scrtext_s,
        scrtext_m  TYPE dd04t-scrtext_m,
        scrtext_l  TYPE dd04t-scrtext_l,
      END OF ty_dd04_texts .
    TYPES:
      tt_dd04_texts TYPE STANDARD TABLE OF ty_dd04_texts .

    CONSTANTS c_longtext_id_dtel TYPE dokil-id VALUE 'DE' ##NO_TEXT.

    METHODS serialize_texts
      IMPORTING
        !ii_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_texts
      IMPORTING
        !ii_xml   TYPE REF TO zif_abapgit_xml_input
        !is_dd04v TYPE dd04v
      RAISING
        zcx_abapgit_exception .