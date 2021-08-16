  METHOD run.

    IF gv_username IS INITIAL OR gv_password IS INITIAL.
      enter( ).
    ENDIF.

    ii_client->authenticate(
      proxy_authentication = abap_true
      username             = gv_username
      password             = gv_password ).

  ENDMETHOD.