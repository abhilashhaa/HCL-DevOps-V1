  METHOD get_selected_rows.

    DATA: lv_condition TYPE string,
          lr_exporting TYPE REF TO data.

    FIELD-SYMBOLS: <lg_exporting>    TYPE any,
                   <lt_table>        TYPE STANDARD TABLE,
                   <lg_line>         TYPE any,
                   <lg_value>        TYPE any,
                   <lv_selected>     TYPE abap_bool,
                   <lv_selected_row> TYPE LINE OF salv_t_row.

    DATA: lo_data_descr    TYPE REF TO cl_abap_datadescr,
          lo_selections    TYPE REF TO cl_salv_selections,
          lt_selected_rows TYPE salv_t_row.

    ASSIGN mr_table->* TO <lt_table>.
    ASSERT sy-subrc = 0.

    lo_selections = mo_select_list_popup->get_selections( ).

    IF lo_selections->get_selection_mode( ) = if_salv_c_selection_mode=>single.

      lt_selected_rows = lo_selections->get_selected_rows( ).

      LOOP AT lt_selected_rows ASSIGNING <lv_selected_row>.

        READ TABLE <lt_table>
          ASSIGNING <lg_line>
          INDEX <lv_selected_row>.
        CHECK <lg_line> IS ASSIGNED.

        ASSIGN COMPONENT c_fieldname_selected
           OF STRUCTURE <lg_line>
           TO <lv_selected>.
        CHECK <lv_selected> IS ASSIGNED.

        <lv_selected> = abap_true.

      ENDLOOP.

    ENDIF.

    lv_condition = |{ c_fieldname_selected } = ABAP_TRUE|.

    CREATE DATA lr_exporting LIKE LINE OF et_list.
    ASSIGN lr_exporting->* TO <lg_exporting>.

    mo_table_descr ?= cl_abap_tabledescr=>describe_by_data( et_list ).
    lo_data_descr = mo_table_descr->get_table_line_type( ).

    LOOP AT <lt_table> ASSIGNING <lg_line> WHERE (lv_condition).
      CLEAR <lg_exporting>.

      CASE lo_data_descr->kind.
        WHEN cl_abap_elemdescr=>kind_elem.
          ASSIGN COMPONENT c_default_column OF STRUCTURE <lg_line> TO <lg_value>.
          ASSERT <lg_value> IS ASSIGNED.
          <lg_exporting> = <lg_value>.

        WHEN OTHERS.
          MOVE-CORRESPONDING <lg_line> TO <lg_exporting>.

      ENDCASE.
      APPEND <lg_exporting> TO et_list.
    ENDLOOP.

  ENDMETHOD.