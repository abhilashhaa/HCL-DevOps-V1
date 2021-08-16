  METHOD get_authenticator_for_url.
    FIELD-SYMBOLS: <li_authenticator> LIKE LINE OF gt_registered_authenticators.

    LOOP AT gt_registered_authenticators ASSIGNING <li_authenticator>.
      IF <li_authenticator>->supports_url( iv_url ) = abap_true.
        ri_authenticator = <li_authenticator>.
        RETURN.
      ENDIF.
    ENDLOOP.

    RAISE EXCEPTION TYPE zcx_abapgit_2fa_unsupported.
  ENDMETHOD.