  METHOD add_row.

    DATA: lo_row TYPE REF TO cl_salv_form_layout_flow.

    lo_row = io_grid->add_row( ).

    lo_row->create_label( position = 1
                          text     = iv_col_1 ).

    lo_row->create_label( position = 2
                          text     = iv_col_2 ).

  ENDMETHOD.