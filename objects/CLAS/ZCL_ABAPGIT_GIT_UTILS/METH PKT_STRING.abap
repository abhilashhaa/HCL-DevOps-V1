  METHOD pkt_string.

    DATA: lv_x   TYPE x,
          lv_len TYPE i.


    lv_len = strlen( iv_string ).

    IF lv_len >= 255.
      zcx_abapgit_exception=>raise( 'PKT, todo' ).
    ENDIF.

    lv_x = lv_len + 4.

    rv_pkt = rv_pkt && '00' && lv_x && iv_string.

  ENDMETHOD.