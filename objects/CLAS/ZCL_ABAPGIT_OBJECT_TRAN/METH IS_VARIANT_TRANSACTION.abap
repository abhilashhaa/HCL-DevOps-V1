  METHOD is_variant_transaction.

    rv_variant_transaction = boolc( is_tstcp-param(1) = '@' ).

  ENDMETHOD.