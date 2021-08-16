  METHOD zif_abapgit_popups~popup_to_select_from_list.

    DATA: lv_pfstatus     TYPE sypfkey,
          lo_events       TYPE REF TO cl_salv_events_table,
          lo_columns      TYPE REF TO cl_salv_columns_table,
          lt_columns      TYPE salv_t_column_ref,
          ls_column       TYPE salv_s_column_ref,
          lo_column       TYPE REF TO cl_salv_column_list,
          lo_table_header TYPE REF TO cl_salv_form_text.

    FIELD-SYMBOLS: <lt_table>             TYPE STANDARD TABLE,
                   <ls_column_to_display> TYPE zif_abapgit_definitions=>ty_alv_column.

    CLEAR: et_list.

    create_new_table( it_list ).

    ASSIGN mr_table->* TO <lt_table>.
    ASSERT sy-subrc = 0.

    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = mo_select_list_popup
                                CHANGING  t_table = <lt_table> ).

        CASE iv_selection_mode.
          WHEN if_salv_c_selection_mode=>single.
            lv_pfstatus = '110'.

          WHEN OTHERS.
            lv_pfstatus = '102'.

        ENDCASE.

        mo_select_list_popup->set_screen_status( pfstatus = lv_pfstatus
                                                 report = 'SAPMSVIM' ).

        mo_select_list_popup->set_screen_popup( start_column = iv_start_column
                                                end_column   = iv_end_column
                                                start_line   = iv_start_line
                                                end_line     = iv_end_line ).

        lo_events = mo_select_list_popup->get_event( ).

        SET HANDLER on_select_list_link_click FOR lo_events.
        SET HANDLER on_select_list_function_click FOR lo_events.
        SET HANDLER on_double_click FOR lo_events.

        IF iv_title CN ' _0'.
          mo_select_list_popup->get_display_settings( )->set_list_header( iv_title ).
        ENDIF.

        IF iv_header_text CN ' _0'.
          CREATE OBJECT lo_table_header
            EXPORTING
              text = iv_header_text.
          mo_select_list_popup->set_top_of_list( lo_table_header ).
        ENDIF.

        mo_select_list_popup->get_display_settings( )->set_striped_pattern( iv_striped_pattern ).
        mo_select_list_popup->get_selections( )->set_selection_mode( iv_selection_mode ).

        lo_columns = mo_select_list_popup->get_columns( ).
        lt_columns = lo_columns->get( ).
        lo_columns->set_optimize( iv_optimize_col_width ).

        LOOP AT lt_columns INTO ls_column.

          lo_column ?= ls_column-r_column.

          IF    iv_selection_mode    = if_salv_c_selection_mode=>multiple
            AND ls_column-columnname = c_fieldname_selected.
            lo_column->set_cell_type( if_salv_c_cell_type=>checkbox_hotspot ).
            lo_column->set_output_length( 20 ).
            lo_column->set_short_text( |{ iv_select_column_text }| ).
            lo_column->set_medium_text( |{ iv_select_column_text }| ).
            lo_column->set_long_text( |{ iv_select_column_text }| ).
            CONTINUE.
          ENDIF.

          READ TABLE it_columns_to_display
            ASSIGNING <ls_column_to_display>
            WITH KEY name = ls_column-columnname.

          CASE sy-subrc.
            WHEN 0.
              IF <ls_column_to_display>-text CN ' _0'.
                lo_column->set_short_text( |{ <ls_column_to_display>-text }| ).
                lo_column->set_medium_text( |{ <ls_column_to_display>-text }| ).
                lo_column->set_long_text( |{ <ls_column_to_display>-text }| ).
              ENDIF.

              IF <ls_column_to_display>-length > 0.
                lo_column->set_output_length( <ls_column_to_display>-length ).
              ENDIF.

            WHEN OTHERS.
              " Hide column
              lo_column->set_technical( abap_true ).

          ENDCASE.

        ENDLOOP.

        mo_select_list_popup->display( ).

      CATCH cx_salv_msg.
        zcx_abapgit_exception=>raise( 'Error from POPUP_TO_SELECT_FROM_LIST' ).
    ENDTRY.

    IF mv_cancel = abap_true.
      mv_cancel = abap_false.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    get_selected_rows( IMPORTING et_list = et_list ).

    CLEAR: mo_select_list_popup,
           mr_table,
           mo_table_descr.

  ENDMETHOD.