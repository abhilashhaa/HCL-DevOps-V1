  METHOD zif_abapgit_object~serialize.

    DATA: ls_transaction_variant TYPE ty_transaction_variant.

    ls_transaction_variant-shdtvciu-tcvariant = ms_item-obj_name.

    CALL FUNCTION 'RS_HDSYS_READ_TC_VARIANT_DB'
      EXPORTING
        tcvariant               = ls_transaction_variant-shdtvciu-tcvariant
        flag_client_independent = abap_true
      IMPORTING
        header_tcvariant        = ls_transaction_variant-shdtvciu
      TABLES
        screen_variants         = ls_transaction_variant-shdtvsvciu[]
        inactive_functions      = ls_transaction_variant-shdfvguicu[]
      EXCEPTIONS
        no_variant              = 1
        OTHERS                  = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

*   Clear all user details
    CLEAR: ls_transaction_variant-shdtvciu-crdate,
           ls_transaction_variant-shdtvciu-cruser,
           ls_transaction_variant-shdtvciu-chdate,
           ls_transaction_variant-shdtvciu-chuser.

    SELECT *
    FROM shdttciu
    INTO TABLE ls_transaction_variant-shdttciu[]
    WHERE tcvariant = ls_transaction_variant-shdtvciu-tcvariant.

    io_xml->add( iv_name = 'STVI'
                 ig_data = ls_transaction_variant ).

  ENDMETHOD.