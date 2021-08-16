  METHOD transaction_read.

    DATA: lt_tcodes   TYPE TABLE OF tstc,
          lt_gui_attr TYPE TABLE OF tstcc.

    CLEAR: es_transaction, es_gui_attr.

    CALL FUNCTION 'RPY_TRANSACTION_READ'
      EXPORTING
        transaction      = iv_transaction
      TABLES
        tcodes           = lt_tcodes
        gui_attributes   = lt_gui_attr
      EXCEPTIONS
        permission_error = 1
        cancelled        = 2
        not_found        = 3
        object_not_found = 4
        OTHERS           = 5.
    IF sy-subrc = 4 OR sy-subrc = 3.
      RETURN.
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from RPY_TRANSACTION_READ' ).
    ENDIF.

    READ TABLE lt_tcodes INDEX 1 INTO es_transaction.
    ASSERT sy-subrc = 0.
    READ TABLE lt_gui_attr INDEX 1 INTO es_gui_attr.
    ASSERT sy-subrc = 0.

  ENDMETHOD.