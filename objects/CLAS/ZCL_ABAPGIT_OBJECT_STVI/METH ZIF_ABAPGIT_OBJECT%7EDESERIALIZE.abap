  METHOD zif_abapgit_object~deserialize.

    DATA: ls_transaction_variant TYPE ty_transaction_variant.

    DATA: lv_text TYPE natxt.

    io_xml->read(
      EXPORTING
        iv_name = 'STVI'
      CHANGING
        cg_data = ls_transaction_variant ).

    CALL FUNCTION 'ENQUEUE_ESTCVARCIU'
      EXPORTING
        tcvariant = ls_transaction_variant-shdtvciu-tcvariant
      EXCEPTIONS
        OTHERS    = 01.
    IF sy-subrc <> 0.
      MESSAGE e413(ms) WITH ls_transaction_variant-shdtvciu-tcvariant INTO lv_text.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    corr_insert( iv_package = iv_package ).

*   Populate user details
    ls_transaction_variant-shdtvciu-crdate = sy-datum.
    ls_transaction_variant-shdtvciu-cruser = sy-uname.
    ls_transaction_variant-shdtvciu-chdate = sy-datum.
    ls_transaction_variant-shdtvciu-chuser = sy-uname.

    MODIFY shdtvciu   FROM ls_transaction_variant-shdtvciu.
    MODIFY shdttciu   FROM TABLE ls_transaction_variant-shdttciu[].
    INSERT shdfvguicu FROM TABLE ls_transaction_variant-shdfvguicu[] ACCEPTING DUPLICATE KEYS.
    INSERT shdtvsvciu FROM TABLE ls_transaction_variant-shdtvsvciu[] ACCEPTING DUPLICATE KEYS.

    CALL FUNCTION 'DEQUEUE_ESTCVARCIU'
      EXPORTING
        tcvariant = ls_transaction_variant-shdtvciu-tcvariant.

  ENDMETHOD.