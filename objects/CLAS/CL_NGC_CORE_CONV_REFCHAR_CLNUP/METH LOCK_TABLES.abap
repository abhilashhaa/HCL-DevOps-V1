  METHOD lock_tables.

    DATA:
      lv_varkey  TYPE rstable-varkey,
      lt_tabname TYPE STANDARD TABLE OF rstable-tabname.

    rv_error   = abap_false.
    lv_varkey  = sy-mandt.
    lt_tabname = VALUE #( ( 'AUSP' ) ).

    LOOP AT lt_tabname REFERENCE INTO DATA(lr_tabname).
      CALL FUNCTION 'ENQUEUE_E_TABLE'
        EXPORTING
          tabname        = lr_tabname->*
          varkey         = lv_varkey
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          OTHERS         = 3.

      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 1.
            mo_conv_logger->log_message(
              iv_id     = 'NGC_CORE_DB'
              iv_type   = 'E'
              iv_number = '006'
              iv_param1 = CONV #( lr_tabname->* )
            ) ##NO_TEXT.
          WHEN 2 OR 3.
            mo_conv_logger->log_message(
              iv_id     = 'NGC_CORE_DB'
              iv_type   = 'E'
              iv_number = '007'
              iv_param1 = CONV #( lr_tabname->* )
            ) ##NO_TEXT.
        ENDCASE.

        me->unlock_tables( ).

        rv_error = abap_true.
        EXIT.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.