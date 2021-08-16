  METHOD set.

    DATA: lv_concat TYPE string.

    ASSERT NOT iv_uri IS INITIAL.

    IF iv_username IS INITIAL OR iv_password IS INITIAL.
      RETURN.
    ENDIF.

    CONCATENATE iv_username ':' iv_password INTO lv_concat.

    rv_auth = cl_http_utility=>if_http_utility~encode_base64( lv_concat ).

    CONCATENATE 'Basic' rv_auth INTO rv_auth
      SEPARATED BY space.

    append( iv_uri  = iv_uri
            iv_auth = rv_auth ).

  ENDMETHOD.