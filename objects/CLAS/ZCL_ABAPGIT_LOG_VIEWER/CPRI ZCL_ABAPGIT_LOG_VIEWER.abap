  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_log_out,
        type      TYPE icon_d,
        msg       TYPE string,
        obj_type  TYPE trobjtype,
        obj_name  TYPE sobj_name,
        exception TYPE REF TO cx_root,
        longtext  TYPE icon_d,
        t100      TYPE icon_d,
        source    TYPE icon_d,
        callstack TYPE icon_d,
        cell_type TYPE salv_t_int4_column,
      END OF ty_log_out.
    TYPES:
      tty_log_out TYPE STANDARD TABLE OF ty_log_out
                                WITH NON-UNIQUE DEFAULT KEY.

    CLASS-METHODS:
      prepare_log_for_display
        IMPORTING
          ii_log            TYPE REF TO zif_abapgit_log
        RETURNING
          VALUE(rt_log_out) TYPE tty_log_out,

      show_longtext
        IMPORTING
          is_log TYPE ty_log_out
        RAISING
          zcx_abapgit_exception,

      goto_source
        IMPORTING
          is_log TYPE ty_log_out
        RAISING
          zcx_abapgit_exception,

      goto_callstack
        IMPORTING
          is_log TYPE ty_log_out
        RAISING
          zcx_abapgit_exception,

      goto_t100_message
        IMPORTING
          is_log TYPE ty_log_out
        RAISING
          zcx_abapgit_exception,

      on_link_click FOR EVENT link_click OF cl_salv_events_table
        IMPORTING row column,

      dispatch
        IMPORTING
          is_log    TYPE ty_log_out
          iv_column TYPE salv_de_column
        RAISING
          zcx_abapgit_exception,

      calculate_cell_type,

      get_exception_viewer
        IMPORTING
          is_log                     TYPE ty_log_out
        RETURNING
          VALUE(ro_exception_viewer) TYPE REF TO zcl_abapgit_exception_viewer.

    CLASS-DATA:
      gt_log TYPE tty_log_out.
