  PRIVATE SECTION.

    TYPES BEGIN OF ty_docu.
    TYPES language TYPE dm40t-sprache.
    TYPES header   TYPE thead.
    TYPES content TYPE xstring.
    TYPES itf     TYPE tsftext.
    TYPES END OF ty_docu.

    TYPES ty_docu_lines TYPE STANDARD TABLE OF ty_docu WITH DEFAULT KEY.

    DATA mv_entity_id TYPE udentity.

    CONSTANTS c_text_object_type TYPE lxeobjtype VALUE 'IM' ##NO_TEXT.
    CONSTANTS c_active_state TYPE as4local VALUE 'A' ##NO_TEXT.


    METHODS build_text_name
      IMPORTING VALUE(iv_id)     TYPE tdid
      RETURNING VALUE(rv_result) TYPE doku_obj.

    METHODS is_name_permitted
      RAISING
        zcx_abapgit_exception.

    METHODS delete_docu_uen
      RAISING zcx_abapgit_exception.

    METHODS delete_docu_url
      RAISING zcx_abapgit_exception.

    METHODS delete_docu_usp
      RAISING zcx_abapgit_exception.



    METHODS deserialize_docu_uen
      IMPORTING
        io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception.

    METHODS deserialize_docu_url
      IMPORTING
        io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception.

    METHODS deserialize_docu_usp
      IMPORTING
        io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception.



    METHODS serialize_docu_uen
      IMPORTING
        io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception.

    METHODS serialize_docu_url
      IMPORTING
        io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception.

    METHODS serialize_docu_xxxx
      IMPORTING VALUE(iv_id)     TYPE tdid
      RETURNING VALUE(rt_result) TYPE ty_docu_lines.

    METHODS serialize_docu_usp
      IMPORTING
        io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception.

    METHODS deserialize_docu_xxxx
      IMPORTING
        it_docu TYPE ty_docu_lines
      RAISING
        zcx_abapgit_exception.

