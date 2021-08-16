  METHOD show_log.

    DATA: lr_log         TYPE REF TO ty_log_out,
          lo_alv         TYPE REF TO cl_salv_table,
          lx_error       TYPE REF TO cx_salv_error,
          lo_form_header TYPE REF TO cl_salv_form_header_info,
          lo_columns     TYPE REF TO cl_salv_columns_table,
          lo_column      TYPE REF TO cl_salv_column,
          lo_functions   TYPE REF TO cl_salv_functions_list,
          lv_add_obj_col TYPE abap_bool,
          lo_event       TYPE REF TO cl_salv_events_table.

    gt_log = prepare_log_for_display( ii_log = ii_log ).

    "check if log contains any object info
    LOOP AT gt_log REFERENCE INTO lr_log.
      IF lr_log->obj_type IS NOT INITIAL OR lr_log->obj_name IS NOT INITIAL.
        lv_add_obj_col = abap_true.
      ENDIF.
    ENDLOOP.

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = lo_alv
          CHANGING
            t_table      = gt_log ).

        lo_functions = lo_alv->get_functions( ).
        lo_functions->set_all( ).

        lo_columns = lo_alv->get_columns( ).

        lo_columns->set_optimize( ).
        lo_columns->set_cell_type_column( |CELL_TYPE| ).

        calculate_cell_type( ).

        lo_column = lo_columns->get_column( |TYPE| ).
        lo_column->set_medium_text( |Type| ).

        lo_column = lo_columns->get_column( |MSG| ).
        lo_column->set_medium_text( |Message| ).

        lo_column = lo_columns->get_column( |LONGTEXT| ).
        lo_column->set_medium_text( |Longtext| ).

        lo_column = lo_columns->get_column( |T100| ).
        lo_column->set_medium_text( |Goto message| ).

        lo_column = lo_columns->get_column( |SOURCE| ).
        lo_column->set_medium_text( |Goto source| ).

        lo_column = lo_columns->get_column( |CALLSTACK| ).
        lo_column->set_medium_text( |Show callstack| ).

        IF lv_add_obj_col = abap_true.
          lo_column = lo_columns->get_column( |OBJ_TYPE| ).
          lo_column->set_medium_text( |Object Type| ).

          lo_column = lo_columns->get_column( |OBJ_NAME| ).
          lo_column->set_medium_text( |Object Name| ).
        ELSE.
          "hide object columns
          lo_column = lo_columns->get_column( |OBJ_TYPE| ).
          lo_column->set_technical( abap_true ).

          lo_column = lo_columns->get_column( |OBJ_NAME| ).
          lo_column->set_technical( abap_true ).
        ENDIF.

        lo_alv->set_screen_popup( start_column = 10
                                  end_column   = 180
                                  start_line   = 4
                                  end_line     = 25 ).

        CREATE OBJECT lo_form_header
          EXPORTING
            text = iv_header_text.

        lo_alv->set_top_of_list( lo_form_header ).

        lo_event = lo_alv->get_event( ).

        SET HANDLER on_link_click FOR lo_event.

        lo_alv->display( ).

      CATCH cx_salv_error INTO lx_error.
        MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.