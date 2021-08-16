  METHOD constructor.

    parse( ii_client ).

    mv_ha1 = md5( |{ iv_username }:{ mv_realm }:{ iv_password }| ).

    mv_username = iv_username.

  ENDMETHOD.