  METHOD run.

    DATA: lv_response TYPE string,
          lv_method   TYPE string,
          lv_cnonce   TYPE string,
          lv_uri      TYPE string,
          lv_auth     TYPE string.


    ASSERT NOT mv_nonce IS INITIAL.

    lv_method = ii_client->request->get_header_field( '~request_method' ).
    lv_uri = ii_client->request->get_header_field( '~request_uri' ).

    CALL FUNCTION 'GENERAL_GET_RANDOM_STRING'
      EXPORTING
        number_chars  = 24
      IMPORTING
        random_string = lv_cnonce.

    lv_response = hash(
      iv_qop    = mv_qop
      iv_nonce  = mv_nonce
      iv_uri    = lv_uri
      iv_method = lv_method
      iv_cnonse = lv_cnonce ).

* client response
    lv_auth = |Digest username="{ mv_username
      }", realm="{ mv_realm
      }", nonce="{ mv_nonce
      }", uri="{ lv_uri
      }", qop={ mv_qop
      }, nc={ gv_nc
      }, cnonce="{ lv_cnonce
      }", response="{ lv_response }"|.

    ii_client->request->set_header_field(
      name  = 'Authorization'
      value = lv_auth ).

  ENDMETHOD.