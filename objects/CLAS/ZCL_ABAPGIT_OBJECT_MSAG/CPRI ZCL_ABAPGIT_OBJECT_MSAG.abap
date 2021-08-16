  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_t100_texts,
        sprsl TYPE t100-sprsl,
        msgnr TYPE t100-msgnr,
        text  TYPE t100-text,
      END OF ty_t100_texts .
    TYPES:
      tt_t100_texts TYPE STANDARD TABLE OF ty_t100_texts .
    TYPES:
      tty_t100      TYPE STANDARD TABLE OF t100
                           WITH NON-UNIQUE DEFAULT KEY .

    METHODS serialize_texts
      IMPORTING
        !ii_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_texts
      IMPORTING
        !ii_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_longtexts_msag
      IMPORTING
        !it_t100 TYPE tty_t100
        !ii_xml  TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS delete_msgid
      IMPORTING
        !iv_message_id TYPE arbgb .
    METHODS free_access_permission
      IMPORTING
        !iv_message_id TYPE arbgb .
    METHODS delete_documentation
      IMPORTING
        !iv_message_id TYPE arbgb .