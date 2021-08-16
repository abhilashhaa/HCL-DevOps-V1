  METHOD get_http_client_for_url.
    DATA: lo_proxy       TYPE REF TO zcl_abapgit_proxy_config,
          lx_abapgit_exc TYPE REF TO zcx_abapgit_exception,
          lv_error_text  TYPE string.

    CREATE OBJECT lo_proxy.
    cl_http_client=>create_by_url(
      EXPORTING
        url                = iv_url
        ssl_id             = zcl_abapgit_exit=>get_instance( )->get_ssl_id( )
        proxy_host         = lo_proxy->get_proxy_url( iv_url )
        proxy_service      = lo_proxy->get_proxy_port( iv_url )
      IMPORTING
        client             = ri_client
      EXCEPTIONS
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        OTHERS             = 4 ).
    IF sy-subrc <> 0.
      raise_comm_error_from_sy( ).
    ENDIF.

    IF lo_proxy->get_proxy_authentication( iv_url ) = abap_true.
      TRY.
          zcl_abapgit_proxy_auth=>run( ri_client ).
        CATCH zcx_abapgit_exception INTO lx_abapgit_exc.
          lv_error_text = lx_abapgit_exc->get_text( ).
          IF lv_error_text IS INITIAL.
            lv_error_text = `Proxy authentication error`.
          ENDIF.
          RAISE EXCEPTION TYPE zcx_abapgit_2fa_comm_error
            EXPORTING
              mv_text  = lv_error_text
              previous = lx_abapgit_exc.
      ENDTRY.
    ENDIF.
  ENDMETHOD.