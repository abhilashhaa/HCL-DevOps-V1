  PRIVATE SECTION.

    TYPES:
      ty_sval_tt TYPE STANDARD TABLE OF sval WITH DEFAULT KEY.

    CONSTANTS c_fieldname_selected TYPE lvc_fname VALUE `SELECTED` ##NO_TEXT.
    CONSTANTS c_answer_cancel      TYPE c LENGTH 1 VALUE 'A' ##NO_TEXT.

    DATA mo_select_list_popup TYPE REF TO cl_salv_table .
    DATA mr_table TYPE REF TO data .
    DATA mv_cancel TYPE abap_bool VALUE abap_false.
    DATA mo_table_descr TYPE REF TO cl_abap_tabledescr .

    METHODS add_field
      IMPORTING
        !iv_tabname    TYPE sval-tabname
        !iv_fieldname  TYPE sval-fieldname
        !iv_fieldtext  TYPE sval-fieldtext
        !iv_value      TYPE clike DEFAULT ''
        !iv_field_attr TYPE sval-field_attr DEFAULT ''
        !iv_obligatory TYPE spo_obl OPTIONAL
      CHANGING
        !ct_fields     TYPE ty_sval_tt .
    METHODS create_new_table
      IMPORTING
        !it_list TYPE STANDARD TABLE .
    METHODS get_selected_rows
      EXPORTING
        !et_list TYPE INDEX TABLE .
    METHODS on_select_list_link_click
        FOR EVENT link_click OF cl_salv_events_table
      IMPORTING
        !row
        !column .
    METHODS on_select_list_function_click
        FOR EVENT added_function OF cl_salv_events_table
      IMPORTING
        !e_salv_function .
    METHODS on_double_click
        FOR EVENT double_click OF cl_salv_events_table
      IMPORTING
        !row
        !column .
    METHODS extract_field_values
      IMPORTING
        it_fields           TYPE ty_sval_tt
      EXPORTING
        ev_url              TYPE abaptxt255-line
        ev_package          TYPE tdevc-devclass
        ev_branch           TYPE textl-line
        ev_display_name     TYPE trm255-text
        ev_folder_logic     TYPE string
        ev_ign_subpkg       TYPE abap_bool
        ev_master_lang_only TYPE abap_bool.
    TYPES:
      ty_lt_fields TYPE STANDARD TABLE OF sval WITH DEFAULT KEY.
    METHODS _popup_3_get_values
      IMPORTING iv_popup_title    TYPE string
                iv_no_value_check TYPE abap_bool DEFAULT abap_false
      EXPORTING ev_value_1        TYPE spo_value
                ev_value_2        TYPE spo_value
                ev_value_3        TYPE spo_value
      CHANGING  ct_fields         TYPE ty_lt_fields
      RAISING   zcx_abapgit_exception.
    METHODS popup_get_from_free_selections
      IMPORTING
        iv_title      TYPE zcl_abapgit_free_sel_dialog=>ty_syst_title OPTIONAL
        iv_frame_text TYPE zcl_abapgit_free_sel_dialog=>ty_syst_title OPTIONAL
      CHANGING
        ct_fields     TYPE zcl_abapgit_free_sel_dialog=>ty_free_sel_field_tab
      RAISING
        zcx_abapgit_cancel
        zcx_abapgit_exception.
    METHODS validate_folder_logic
      IMPORTING
        iv_folder_logic TYPE string
      RAISING
        zcx_abapgit_exception.