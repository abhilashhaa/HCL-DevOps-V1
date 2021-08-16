  PRIVATE SECTION.
    DATA:
      mx_error     TYPE REF TO zcx_abapgit_exception,
      mt_callstack TYPE abap_callstack.

    METHODS:
      build_top_of_list
        IMPORTING
          is_top_of_stack TYPE abap_callstack_line
        RETURNING
          VALUE(ro_form)  TYPE REF TO cl_salv_form_element,

      add_row
        IMPORTING
          io_grid  TYPE REF TO cl_salv_form_layout_grid
          iv_col_1 TYPE csequence
          iv_col_2 TYPE csequence,

      on_double_click FOR EVENT double_click OF cl_salv_events_table
        IMPORTING
            row column,

      set_text
        IMPORTING
          io_columns TYPE REF TO cl_salv_columns_table
          iv_column  TYPE lvc_fname
          iv_text    TYPE string
        RAISING
          cx_salv_not_found,

      goto_source_code
        IMPORTING
          is_callstack TYPE abap_callstack_line
        RAISING
          zcx_abapgit_exception,

      extract_classname
        IMPORTING
          iv_mainprogram      TYPE abap_callstack_line-mainprogram
        RETURNING
          VALUE(rv_classname) TYPE tadir-obj_name,

      get_top_of_callstack
        RETURNING
          VALUE(rs_top_of_callstack) TYPE abap_callstack_line
        RAISING
          zcx_abapgit_exception.
