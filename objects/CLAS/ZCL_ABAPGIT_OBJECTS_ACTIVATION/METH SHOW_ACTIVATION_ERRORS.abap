  METHOD show_activation_errors.

    DATA: lt_lines      TYPE STANDARD TABLE OF trlog,
          lv_logname_db TYPE ddprh-protname,
          li_log        TYPE REF TO zif_abapgit_log.

    FIELD-SYMBOLS: <ls_line> LIKE LINE OF lt_lines.


    lv_logname_db = iv_logname.

    CALL FUNCTION 'TR_READ_LOG'
      EXPORTING
        iv_log_type   = 'DB'
        iv_logname_db = lv_logname_db
      TABLES
        et_lines      = lt_lines
      EXCEPTIONS
        invalid_input = 1
        access_error  = 2
        OTHERS        = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from TR_READ_LOG' ).
    ENDIF.

    DELETE lt_lines WHERE severity <> 'E'.

    CREATE OBJECT li_log TYPE zcl_abapgit_log.

    LOOP AT lt_lines ASSIGNING <ls_line>.
      li_log->add( <ls_line>-line ).
    ENDLOOP.

    IF li_log->count( ) > 0.
      zcl_abapgit_log_viewer=>show_log( iv_header_text = 'Activation Errors'
                                        ii_log         = li_log ).
    ENDIF.

  ENDMETHOD.