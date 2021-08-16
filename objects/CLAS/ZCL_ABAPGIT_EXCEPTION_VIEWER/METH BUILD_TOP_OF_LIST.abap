  METHOD build_top_of_list.

    DATA: lo_grid TYPE REF TO cl_salv_form_layout_grid.

    CREATE OBJECT lo_grid
      EXPORTING
        columns = 2.

    add_row( io_grid  = lo_grid
             iv_col_1 = 'Main program:'
             iv_col_2 = is_top_of_stack-mainprogram ).

    add_row( io_grid  = lo_grid
             iv_col_1 = 'Include name:'
             iv_col_2 = is_top_of_stack-include ).

    add_row( io_grid  = lo_grid
             iv_col_1 = 'Source line'
             iv_col_2 = |{ is_top_of_stack-line }| ).

    ro_form = lo_grid.

  ENDMETHOD.