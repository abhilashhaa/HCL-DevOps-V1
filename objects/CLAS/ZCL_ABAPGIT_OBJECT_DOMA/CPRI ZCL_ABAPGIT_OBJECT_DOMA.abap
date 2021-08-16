  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_dd01_texts,
        ddlanguage TYPE dd01v-ddlanguage,
        ddtext     TYPE dd01v-ddtext,
      END OF ty_dd01_texts .
    TYPES:
      BEGIN OF ty_dd07_texts,
        valpos     TYPE dd07v-valpos,
        ddlanguage TYPE dd07v-ddlanguage,
        domvalue_l TYPE dd07v-domvalue_l,
        domvalue_h TYPE dd07v-domvalue_h,
        ddtext     TYPE dd07v-ddtext,
        domval_ld  TYPE dd07v-domval_ld,
        domval_hd  TYPE dd07v-domval_hd,
      END OF ty_dd07_texts .
    TYPES:
      tt_dd01_texts TYPE STANDARD TABLE OF ty_dd01_texts .
    TYPES:
      tt_dd07_texts TYPE STANDARD TABLE OF ty_dd07_texts .

    CONSTANTS c_longtext_id_doma TYPE dokil-id VALUE 'DO' ##NO_TEXT.

    METHODS serialize_texts
      IMPORTING
        !ii_xml   TYPE REF TO zif_abapgit_xml_output
        !it_dd07v TYPE dd07v_tab
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_texts
      IMPORTING
        !ii_xml   TYPE REF TO zif_abapgit_xml_input
        !is_dd01v TYPE dd01v
        !it_dd07v TYPE dd07v_tab
      RAISING
        zcx_abapgit_exception .