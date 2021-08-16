  METHOD hash.

    DATA: lv_ha2 TYPE string.


    lv_ha2 = md5( |{ iv_method }:{ iv_uri }| ).

    ASSERT NOT iv_cnonse IS INITIAL.

    rv_response = md5( |{ mv_ha1 }:{ iv_nonce }:{ gv_nc }:{ iv_cnonse }:{ iv_qop }:{ lv_ha2 }| ).

  ENDMETHOD.