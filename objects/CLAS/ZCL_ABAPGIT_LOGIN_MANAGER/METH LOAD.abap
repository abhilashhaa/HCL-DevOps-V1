  METHOD load.

    DATA: ls_auth LIKE LINE OF gt_auth.

    READ TABLE gt_auth INTO ls_auth WITH KEY uri = zcl_abapgit_url=>host( iv_uri ).
    IF sy-subrc = 0.
      rv_authorization = ls_auth-authorization.

      IF NOT ii_client IS INITIAL.
        ii_client->request->set_header_field(
          name  = 'authorization'
          value = ls_auth-authorization ).
        ii_client->propertytype_logon_popup = ii_client->co_disabled.
      ENDIF.
    ENDIF.

  ENDMETHOD.