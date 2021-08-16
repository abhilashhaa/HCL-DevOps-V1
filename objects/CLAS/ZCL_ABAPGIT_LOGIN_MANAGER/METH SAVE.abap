  METHOD save.

    DATA: lv_auth TYPE string.

    lv_auth = ii_client->request->get_header_field( 'authorization' ).

    IF NOT lv_auth IS INITIAL.
      append( iv_uri  = iv_uri
              iv_auth = lv_auth ).
    ENDIF.

  ENDMETHOD.