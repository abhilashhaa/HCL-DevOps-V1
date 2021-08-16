  METHOD show_callstack.

    DATA: lx_error   TYPE REF TO cx_salv_error,
          lo_event   TYPE REF TO cl_salv_events_table,
          lo_columns TYPE REF TO cl_salv_columns_table,
          lo_alv     TYPE REF TO cl_salv_table.

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = lo_alv
          CHANGING
            t_table      = mt_callstack ).

        lo_alv->get_columns( )->set_optimize( ).

        lo_alv->set_top_of_list( build_top_of_list( get_top_of_callstack( ) ) ).

        lo_alv->set_screen_popup( start_column = 10
                                  end_column   = 180
                                  start_line   = 3
                                  end_line     = 30 ).

        lo_event = lo_alv->get_event( ).

        lo_columns = lo_alv->get_columns( ).

        set_text( io_columns = lo_columns
                  iv_column  = |LINE|
                  iv_text    = |Line| ).

        set_text( io_columns = lo_columns
                  iv_column  = |LINE|
                  iv_text    = |Line| ).

        set_text( io_columns = lo_columns
                  iv_column  = |BLOCKTYPE|
                  iv_text    = |Event Type| ).

        set_text( io_columns = lo_columns
                  iv_column  = |BLOCKNAME|
                  iv_text    = |Event| ).

        set_text( io_columns = lo_columns
                  iv_column  = |FLAG_SYSTEM|
                  iv_text    = |System| ).

        SET HANDLER on_double_click FOR lo_event.

        lo_alv->display( ).

      CATCH cx_salv_error INTO lx_error.
        MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.