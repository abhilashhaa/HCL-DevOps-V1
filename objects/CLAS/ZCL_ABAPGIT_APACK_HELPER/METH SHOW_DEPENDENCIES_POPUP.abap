  METHOD show_dependencies_popup.

    TYPES:
      BEGIN OF lty_color_line,
        exception(1) TYPE c,
        color        TYPE lvc_t_scol.
        INCLUDE TYPE ty_dependency_status.
    TYPES: t_hyperlink  TYPE salv_t_int4_column,
      END OF lty_color_line.

    TYPES: lty_color_tab TYPE STANDARD TABLE OF lty_color_line WITH DEFAULT KEY.

    DATA: lo_alv                 TYPE REF TO cl_salv_table,
          lo_functional_settings TYPE REF TO cl_salv_functional_settings,
          lo_hyperlinks          TYPE REF TO cl_salv_hyperlinks,
          lo_column              TYPE REF TO cl_salv_column,
          lo_column_table        TYPE REF TO cl_salv_column_table,
          lo_columns             TYPE REF TO cl_salv_columns_table,
          lt_columns             TYPE salv_t_column_ref,
          ls_column              LIKE LINE OF lt_columns,
          lt_color_table         TYPE lty_color_tab,
          lt_color_negative      TYPE lvc_t_scol,
          lt_color_normal        TYPE lvc_t_scol,
          lt_color_positive      TYPE lvc_t_scol,
          ls_color               TYPE lvc_s_scol,
          lv_handle              TYPE i,
          ls_hyperlink           TYPE salv_s_int4_column,
          lv_hyperlink           TYPE service_rl,
          lx_ex                  TYPE REF TO cx_root.

    FIELD-SYMBOLS: <ls_line>       TYPE lty_color_line,
                   <ls_dependency> LIKE LINE OF it_dependencies.

    IF it_dependencies IS INITIAL.
      RETURN.
    ENDIF.

    CLEAR: ls_color.
    ls_color-color-col = col_negative.
    APPEND ls_color TO lt_color_negative.

    CLEAR: ls_color.
    ls_color-color-col = col_normal.
    APPEND ls_color TO lt_color_normal.

    CLEAR: ls_color.
    ls_color-color-col = col_positive.
    APPEND ls_color TO lt_color_positive.

    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table  = lo_alv
                                CHANGING  t_table       = lt_color_table ).

        lo_functional_settings = lo_alv->get_functional_settings( ).
        lo_hyperlinks = lo_functional_settings->get_hyperlinks( ).

        lo_columns = lo_alv->get_columns( ).
        lt_columns = lo_columns->get( ).
        LOOP AT lt_columns INTO ls_column WHERE columnname CP 'SEM_VERSION-*'.
          ls_column-r_column->set_technical( ).
        ENDLOOP.

        lo_column = lo_columns->get_column( 'MET' ).
        lo_column->set_technical( ).

        lo_column = lo_columns->get_column( 'GROUP_ID' ).
        lo_column->set_short_text( 'Org/ProjId' ).

        lo_columns->set_color_column( 'COLOR' ).
        lo_columns->set_exception_column( 'EXCEPTION' ).
        lo_columns->set_hyperlink_entry_column( 'T_HYPERLINK' ).
        lo_columns->set_optimize( ).

        lo_column = lo_columns->get_column( 'GROUP_ID' ).
        lo_column->set_short_text( 'Org/ProjId' ).

        lo_column = lo_columns->get_column( 'ARTIFACT_ID' ).
        lo_column->set_short_text( 'Proj. Name' ).

        lo_column = lo_columns->get_column( 'GIT_URL' ).
        lo_column->set_short_text( 'Git URL' ).

        lo_column_table ?= lo_column.
        lo_column_table->set_cell_type( if_salv_c_cell_type=>link ).


        lo_column = lo_columns->get_column( 'VERSION' ).
        lo_column->set_short_text( 'Version' ).

        lo_column = lo_columns->get_column( 'TARGET_PACKAGE' ).
        lo_column->set_technical( ).

        lo_hyperlinks = lo_functional_settings->get_hyperlinks( ).

        CLEAR: lv_handle, ls_color.
        LOOP AT it_dependencies ASSIGNING <ls_dependency>.
          lv_handle = lv_handle + 1.

          APPEND INITIAL LINE TO lt_color_table ASSIGNING <ls_line>.
          MOVE-CORRESPONDING <ls_dependency> TO <ls_line>.

          CASE <ls_line>-met.
            WHEN zif_abapgit_definitions=>gc_yes.
              <ls_line>-color     = lt_color_positive.
              <ls_line>-exception = '3'.
            WHEN zif_abapgit_definitions=>gc_partial.
              <ls_line>-color     = lt_color_normal.
              <ls_line>-exception = '2'.
            WHEN zif_abapgit_definitions=>gc_no.
              <ls_line>-color     = lt_color_negative.
              <ls_line>-exception = '1'.
          ENDCASE.

          CLEAR: ls_hyperlink.
          ls_hyperlink-columnname = 'GIT_URL'.
          ls_hyperlink-value      = lv_handle.
          APPEND ls_hyperlink TO <ls_line>-t_hyperlink.

          lv_hyperlink = <ls_line>-git_url.
          lo_hyperlinks->add_hyperlink( handle    = lv_handle
                                        hyperlink = lv_hyperlink ).

        ENDLOOP.

        UNASSIGN <ls_line>.

        lo_alv->set_screen_popup( start_column = 30
                                  end_column   = 120
                                  start_line   = 10
                                  end_line     = 20 ).
        lo_alv->get_display_settings( )->set_list_header( 'APACK dependencies' ).
        lo_alv->display( ).

      CATCH cx_salv_msg cx_salv_not_found cx_salv_data_error cx_salv_existing INTO lx_ex.
        zcx_abapgit_exception=>raise( lx_ex->get_text( ) ).
    ENDTRY.

  ENDMETHOD.