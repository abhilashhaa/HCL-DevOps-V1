  METHOD zif_abapgit_tag_popups~tag_list_popup.

    DATA: lo_alv          TYPE REF TO cl_salv_table,
          lo_table_header TYPE REF TO cl_salv_form_header_info,
          lo_columns      TYPE REF TO cl_salv_columns_table,
          lx_alv          TYPE REF TO cx_salv_error,
          lt_tags         TYPE zif_abapgit_definitions=>ty_git_tag_list_tt,
          lo_event        TYPE REF TO cl_salv_events_table.

    CLEAR: mt_tags.

    lt_tags = zcl_abapgit_factory=>get_branch_overview( io_repo )->get_tags( ).

    IF lines( lt_tags ) = 0.
      zcx_abapgit_exception=>raise( `There are no tags for this repository` ).
    ENDIF.

    mt_tags = prepare_tags_for_display( lt_tags ).

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   = lo_alv
          CHANGING
            t_table        = mt_tags ).

        lo_columns = lo_alv->get_columns( ).

        lo_columns->get_column( `TYPE` )->set_technical( ).
        lo_columns->get_column( `DISPLAY_NAME` )->set_technical( ).
        lo_columns->get_column( `BODY` )->set_technical( ).

        lo_columns->get_column( `NAME` )->set_medium_text( 'Tag name' ).
        lo_columns->set_column_position( columnname = 'NAME'
                                         position   = 1 ).

        lo_columns->get_column( `TAGGER_NAME` )->set_medium_text( 'Tagger' ).
        lo_columns->set_column_position( columnname = 'TAGGER_NAME'
                                         position   = 2 ).

        lo_columns->get_column( `TAGGER_EMAIL` )->set_medium_text( 'Tagger E-Mail' ).
        lo_columns->set_column_position( columnname = 'TAGGER_EMAIL'
                                         position   = 3 ).

        lo_columns->get_column( `MESSAGE` )->set_medium_text( 'Tag message' ).
        lo_columns->set_column_position( columnname = 'MESSAGE'
                                         position   = 4 ).

        lo_columns->get_column( `BODY_ICON` )->set_medium_text( 'Body' ).
        lo_columns->get_column( `BODY_ICON` )->set_output_length( 4 ).
        lo_columns->set_column_position( columnname = 'BODY_ICON'
                                         position   = 5 ).

        lo_columns->get_column( `SHA1` )->set_output_length( 15 ).
        lo_columns->get_column( `SHA1` )->set_medium_text( 'SHA' ).
        lo_columns->set_column_position( columnname = 'SHA1'
                                         position   = 6 ).

        lo_columns->get_column( `OBJECT` )->set_output_length( 15 ).
        lo_columns->get_column( `OBJECT` )->set_medium_text( 'Object' ).
        lo_columns->set_column_position( columnname = 'OBJECT'
                                         position   = 7 ).

        lo_columns->set_optimize( ).

        lo_alv->set_screen_popup( start_column = 7
                                  end_column   = 200
                                  start_line   = 1
                                  end_line     = 25 ).

        CREATE OBJECT lo_table_header
          EXPORTING
            text = `Tags`.

        lo_alv->set_top_of_list( lo_table_header ).

        lo_event = lo_alv->get_event( ).

        SET HANDLER on_double_click FOR lo_event.

        lo_alv->display( ).

      CATCH cx_salv_error INTO lx_alv.
        zcx_abapgit_exception=>raise( lx_alv->get_text( ) ).
    ENDTRY.

    clean_up( ).

  ENDMETHOD.