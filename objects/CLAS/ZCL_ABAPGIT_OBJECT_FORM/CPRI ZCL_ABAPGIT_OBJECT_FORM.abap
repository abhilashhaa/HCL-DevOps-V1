  PRIVATE SECTION.
    CONSTANTS: c_objectname_form    TYPE thead-tdobject VALUE 'FORM' ##NO_TEXT.
    CONSTANTS: c_objectname_tdlines TYPE thead-tdobject VALUE 'TDLINES' ##NO_TEXT.
    CONSTANTS: c_extension_xml      TYPE string         VALUE 'xml' ##NO_TEXT.
    DATA: mv_form_name  TYPE itcta-tdform.

    TYPES: BEGIN OF tys_form_data,
             form_header   TYPE itcta,
             text_header   TYPE thead,
             orig_language TYPE sy-langu,
             pages         TYPE STANDARD TABLE OF itctg WITH DEFAULT KEY,
             page_windows  TYPE STANDARD TABLE OF itcth WITH DEFAULT KEY,
             paragraphs    TYPE STANDARD TABLE OF itcdp WITH DEFAULT KEY,
             strings       TYPE STANDARD TABLE OF itcds WITH DEFAULT KEY,
             tabs          TYPE STANDARD TABLE OF itcdq WITH DEFAULT KEY,
             windows       TYPE STANDARD TABLE OF itctw WITH DEFAULT KEY,
           END OF tys_form_data,
           tyt_form_data   TYPE STANDARD TABLE OF tys_form_data WITH DEFAULT KEY,
           tyt_form_header TYPE STANDARD TABLE OF itcta WITH DEFAULT KEY,
           tys_form_header TYPE LINE OF tyt_form_header,
           tyt_text_header TYPE STANDARD TABLE OF thead WITH DEFAULT KEY,
           tys_text_header TYPE LINE OF tyt_text_header,
           tyt_lines       TYPE tline_tab.

    METHODS get_last_changes
      IMPORTING
        iv_form_name           TYPE zif_abapgit_definitions=>ty_item-obj_name
      RETURNING
        VALUE(rs_last_changed) TYPE tys_form_header.

    METHODS build_extra_from_header
      IMPORTING
        is_header        TYPE tys_form_header
      RETURNING
        VALUE(rv_result) TYPE string.

    METHODS build_extra_from_header_old
      IMPORTING
        is_header        TYPE tys_form_header
      RETURNING
        VALUE(rv_result) TYPE string.

    METHODS _save_form
      IMPORTING
        it_lines     TYPE tyt_lines
      CHANGING
        cs_form_data TYPE tys_form_data.

    METHODS extract_tdlines
      IMPORTING
        is_form_data    TYPE tys_form_data
      RETURNING
        VALUE(rt_lines) TYPE tyt_lines
      RAISING
        zcx_abapgit_exception.

    METHODS _clear_changed_fields
      CHANGING
        cs_form_data TYPE tys_form_data.

    METHODS compress_lines
      IMPORTING
        is_form_data TYPE tys_form_data
        it_lines     TYPE tyt_lines
      RAISING
        zcx_abapgit_exception.

    METHODS find_form
      IMPORTING
        iv_object_name        TYPE zif_abapgit_definitions=>ty_item-obj_name
      RETURNING
        VALUE(rt_text_header) TYPE tyt_text_header.

    METHODS _read_form
      IMPORTING
        is_text_header TYPE tys_text_header
      EXPORTING
        ev_form_found  TYPE abap_bool
        es_form_data   TYPE tys_form_data
        et_lines       TYPE tyt_lines.

    METHODS _sort_tdlines_by_windows
      CHANGING
        ct_form_windows TYPE tys_form_data-windows
        ct_lines        TYPE tyt_lines.

    METHODS order_check_and_insert
      RAISING
        zcx_abapgit_exception.
