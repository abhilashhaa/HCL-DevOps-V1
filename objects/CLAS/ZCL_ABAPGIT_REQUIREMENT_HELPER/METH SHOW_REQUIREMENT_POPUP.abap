  METHOD show_requirement_popup.

    TYPES: BEGIN OF lty_color_line,
             color TYPE lvc_t_scol.
             INCLUDE TYPE ty_requirement_status.
    TYPES: END OF lty_color_line.

    TYPES: lty_color_tab TYPE STANDARD TABLE OF lty_color_line WITH DEFAULT KEY.

    DATA: lo_alv            TYPE REF TO cl_salv_table,
          lo_column         TYPE REF TO cl_salv_column,
          lo_columns        TYPE REF TO cl_salv_columns_table,
          lt_color_table    TYPE lty_color_tab,
          lt_color_negative TYPE lvc_t_scol,
          lt_color_positive TYPE lvc_t_scol,
          ls_color          TYPE lvc_s_scol,
          lx_ex             TYPE REF TO cx_root.

    FIELD-SYMBOLS: <ls_line>        TYPE lty_color_line,
                   <ls_requirement> LIKE LINE OF it_requirements.


    ls_color-color-col = col_negative.
    APPEND ls_color TO lt_color_negative.

    ls_color-color-col = col_positive.
    APPEND ls_color TO lt_color_positive.

    CLEAR ls_color.

    LOOP AT it_requirements ASSIGNING <ls_requirement>.
      APPEND INITIAL LINE TO lt_color_table ASSIGNING <ls_line>.
      MOVE-CORRESPONDING <ls_requirement> TO <ls_line>.
    ENDLOOP.

    LOOP AT lt_color_table ASSIGNING <ls_line>.
      IF <ls_line>-met = abap_false.
        <ls_line>-color = lt_color_negative.
      ELSE.
        <ls_line>-color = lt_color_positive.
      ENDIF.
    ENDLOOP.
    UNASSIGN <ls_line>.

    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = lo_alv
                                CHANGING t_table       = lt_color_table ).

        lo_columns = lo_alv->get_columns( ).
        lo_columns->get_column( 'MET' )->set_short_text( 'Met' ).
        lo_columns->set_color_column( 'COLOR' ).
        lo_columns->set_optimize( ).

        lo_column = lo_columns->get_column( 'REQUIRED_RELEASE' ).
        lo_column->set_short_text( 'Req. Rel.' ).

        lo_column = lo_columns->get_column( 'REQUIRED_PATCH' ).
        lo_column->set_short_text( 'Req. SP L.' ).

        lo_alv->set_screen_popup( start_column = 30
                                  end_column   = 100
                                  start_line   = 10
                                  end_line     = 20 ).
        lo_alv->get_display_settings( )->set_list_header( 'Requirements' ).
        lo_alv->display( ).

      CATCH cx_salv_msg cx_salv_not_found cx_salv_data_error INTO lx_ex.
        zcx_abapgit_exception=>raise( lx_ex->get_text( ) ).
    ENDTRY.

  ENDMETHOD.