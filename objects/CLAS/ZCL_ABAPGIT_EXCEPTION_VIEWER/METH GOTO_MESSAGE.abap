  METHOD goto_message.

    DATA: lt_bdcdata TYPE STANDARD TABLE OF bdcdata,
          ls_bdcdata LIKE LINE OF lt_bdcdata.

    ls_bdcdata-program  = 'SAPLWBMESSAGES'.
    ls_bdcdata-dynpro   = '0100'.
    ls_bdcdata-dynbegin = abap_true.
    INSERT ls_bdcdata INTO TABLE lt_bdcdata.

    CLEAR: ls_bdcdata.
    ls_bdcdata-fnam = 'RSDAG-ARBGB'.
    ls_bdcdata-fval = mx_error->if_t100_message~t100key-msgid.
    INSERT ls_bdcdata INTO TABLE lt_bdcdata.

    CLEAR: ls_bdcdata.
    ls_bdcdata-fnam = 'MSG_NUMMER'.
    ls_bdcdata-fval = mx_error->if_t100_message~t100key-msgno.
    INSERT ls_bdcdata INTO TABLE lt_bdcdata.

    CLEAR: ls_bdcdata.
    ls_bdcdata-fnam = 'RSDAG-MSGFLAG'.
    ls_bdcdata-fval = 'X'.
    INSERT ls_bdcdata INTO TABLE lt_bdcdata.

    CLEAR: ls_bdcdata.
    ls_bdcdata-fnam = 'BDC_OKCODE'.
    ls_bdcdata-fval = '=WB_DISPLAY'.
    INSERT ls_bdcdata INTO TABLE lt_bdcdata.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode                   = 'SE91'
        mode_val                = 'E'
      TABLES
        using_tab               = lt_bdcdata
      EXCEPTIONS
        call_transaction_denied = 1
        tcode_invalid           = 2
        OTHERS                  = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.