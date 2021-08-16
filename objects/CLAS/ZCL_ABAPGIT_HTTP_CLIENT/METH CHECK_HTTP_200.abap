  METHOD check_http_200.

    DATA: lv_code TYPE i,
          lv_text TYPE string.

    mi_client->response->get_status( IMPORTING code = lv_code ).
    CASE lv_code.
      WHEN 200.
        RETURN. " Success, OK
      WHEN 302.
        zcx_abapgit_exception=>raise( 'Resource access temporarily redirected. Check the URL (HTTP 302)' ).
      WHEN 401.
        zcx_abapgit_exception=>raise( 'Unauthorized access to resource. Check your credentials (HTTP 401)' ).
      WHEN 403.
        zcx_abapgit_exception=>raise( 'Access to resource forbidden (HTTP 403)' ).
      WHEN 404.
        zcx_abapgit_exception=>raise( 'Resource not found. Check the URL (HTTP 404)' ).
      WHEN 407.
        zcx_abapgit_exception=>raise( 'Proxy authentication required. Check your credentials (HTTP 407)' ).
      WHEN 408.
        zcx_abapgit_exception=>raise( 'Request timeout (HTTP 408)' ).
      WHEN 415.
        zcx_abapgit_exception=>raise( 'Unsupported media type (HTTP 415)' ).
      WHEN OTHERS.
        lv_text = mi_client->response->get_cdata( ).
        zcx_abapgit_exception=>raise( |{ lv_text } (HTTP { lv_code })| ).
    ENDCASE.

  ENDMETHOD.