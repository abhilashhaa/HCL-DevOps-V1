  METHOD set_headers.

    DATA: lv_value TYPE string.


    mi_client->request->set_header_field(
        name  = '~request_method'
        value = 'POST' ).

    lv_value = zcl_abapgit_url=>path_name( iv_url ) &&
      '/git-' &&
      iv_service &&
      '-pack'.
    mi_client->request->set_header_field(
        name  = '~request_uri'
        value = lv_value ).

    lv_value = 'application/x-git-'
                  && iv_service && '-pack-request'.
    mi_client->request->set_header_field(
        name  = 'Content-Type'
        value = lv_value ).

    lv_value = 'application/x-git-'
                  && iv_service && '-pack-result'.
    mi_client->request->set_header_field(
        name  = 'Accept'
        value = lv_value ).

    IF mo_digest IS BOUND.
      mo_digest->run( mi_client ).
    ENDIF.

  ENDMETHOD.