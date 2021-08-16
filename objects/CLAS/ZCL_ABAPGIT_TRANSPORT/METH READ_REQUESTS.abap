  METHOD read_requests.
    DATA lt_requests LIKE rt_requests.
    FIELD-SYMBOLS <ls_trkorr> LIKE LINE OF it_trkorr.

    LOOP AT it_trkorr ASSIGNING <ls_trkorr>.
      CALL FUNCTION 'TR_READ_REQUEST_WITH_TASKS'
        EXPORTING
          iv_trkorr     = <ls_trkorr>-trkorr
        IMPORTING
          et_requests   = lt_requests
        EXCEPTIONS
          invalid_input = 1
          OTHERS        = 2.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from TR_READ_REQUEST_WITH_TASKS' ).
      ENDIF.

      APPEND LINES OF lt_requests TO rt_requests.
    ENDLOOP.
  ENDMETHOD.