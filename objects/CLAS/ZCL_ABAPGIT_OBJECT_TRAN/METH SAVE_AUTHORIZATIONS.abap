  METHOD save_authorizations.

    CONSTANTS: lc_hex_chk TYPE x VALUE '04'.
    DATA: ls_transaction TYPE tstc.

    transaction_read( EXPORTING iv_transaction = iv_transaction
                      IMPORTING es_transaction = ls_transaction ).

    DELETE FROM tstca WHERE tcode = iv_transaction.

    IF ls_transaction IS NOT INITIAL.
      INSERT tstca FROM TABLE it_authorizations.
      ls_transaction-cinfo = ls_transaction-cinfo + lc_hex_chk.
      UPDATE tstc SET cinfo = ls_transaction-cinfo WHERE tcode = ls_transaction-tcode.
    ENDIF.

  ENDMETHOD.