  METHOD error.

    IF ii_parser->num_errors( ) <> 0.

      IF zcl_abapgit_ui_factory=>get_gui_functions( )->gui_is_available( ) = abap_true.
        show_parser_errors( ii_parser ).
      ELSE.
        raise_exception_for( ii_parser->get_error( 0 ) ).
      ENDIF.

    ENDIF.

    IF mv_filename IS INITIAL.
      zcx_abapgit_exception=>raise( |Error while parsing XML| ).
    ELSE.
      zcx_abapgit_exception=>raise( |Error while parsing XML file { mv_filename }| ).
    ENDIF.

  ENDMETHOD.