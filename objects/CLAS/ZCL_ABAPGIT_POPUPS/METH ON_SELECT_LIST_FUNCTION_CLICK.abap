  METHOD on_select_list_function_click.

    FIELD-SYMBOLS: <lt_table>    TYPE STANDARD TABLE,
                   <lg_line>     TYPE any,
                   <lv_selected> TYPE abap_bool.

    ASSIGN mr_table->* TO <lt_table>.
    ASSERT sy-subrc = 0.

    CASE e_salv_function.
      WHEN 'O.K.'.
        mv_cancel = abap_false.
        mo_select_list_popup->close_screen( ).

      WHEN 'ABR'.
        "Canceled: clear list to overwrite nothing
        CLEAR <lt_table>.
        mv_cancel = abap_true.
        mo_select_list_popup->close_screen( ).

      WHEN 'SALL'.
        LOOP AT <lt_table> ASSIGNING <lg_line>.

          ASSIGN COMPONENT c_fieldname_selected
                 OF STRUCTURE <lg_line>
                 TO <lv_selected>.
          ASSERT sy-subrc = 0.

          <lv_selected> = abap_true.

        ENDLOOP.

        mo_select_list_popup->refresh( ).

      WHEN 'DSEL'.
        LOOP AT <lt_table> ASSIGNING <lg_line>.

          ASSIGN COMPONENT c_fieldname_selected
                 OF STRUCTURE <lg_line>
                 TO <lv_selected>.
          ASSERT sy-subrc = 0.

          <lv_selected> = abap_false.

        ENDLOOP.

        mo_select_list_popup->refresh( ).

      WHEN OTHERS.
        CLEAR <lt_table>.
        mo_select_list_popup->close_screen( ).
    ENDCASE.

  ENDMETHOD.