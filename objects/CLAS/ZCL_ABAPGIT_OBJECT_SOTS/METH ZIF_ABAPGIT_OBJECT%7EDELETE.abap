  METHOD zif_abapgit_object~delete.

    DATA: lt_sots TYPE tty_sots.

    FIELD-SYMBOLS: <ls_sots> TYPE ty_sots.

    lt_sots = read_sots( ).

    LOOP AT lt_sots ASSIGNING <ls_sots>.

      CALL FUNCTION 'BTFR_DELETE_SINGLE_TEXT'
        EXPORTING
          concept             = <ls_sots>-header-concept
          flag_string         = abap_true
        EXCEPTIONS
          text_not_found      = 1
          invalid_package     = 2
          text_not_changeable = 3
          text_enqueued       = 4
          no_correction       = 5
          parameter_error     = 6
          OTHERS              = 7.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |Error in BTFR_DELETE_SINGLE_TEXT subrc={ sy-subrc }| ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.