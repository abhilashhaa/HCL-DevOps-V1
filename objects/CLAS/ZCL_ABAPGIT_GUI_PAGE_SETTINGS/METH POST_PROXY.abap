  METHOD post_proxy.

    FIELD-SYMBOLS: <ls_post_field> TYPE ihttpnvp.


    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'proxy_url'.
    IF sy-subrc <> 0.
      mv_error = abap_true.
    ENDIF.
    mo_settings->set_proxy_url( <ls_post_field>-value ).

    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'proxy_port'.
    IF sy-subrc <> 0.
      mv_error = abap_true.
    ENDIF.
    mo_settings->set_proxy_port( <ls_post_field>-value ).

    IF is_post_field_checked( 'proxy_auth' ) = abap_true.
      mo_settings->set_proxy_authentication( abap_true ).
    ELSE.
      mo_settings->set_proxy_authentication( abap_false ).
    ENDIF.

    mo_settings->set_proxy_bypass( mt_proxy_bypass ).

  ENDMETHOD.