  METHOD skip_first_pkt.

    DATA: lv_hex    TYPE x LENGTH 1,
          lv_length TYPE i.


* channel
    ASSERT iv_data(2) = '00'.

    lv_hex = to_upper( iv_data+2(2) ).
    lv_length = lv_hex.

    rv_data = iv_data+lv_length.

  ENDMETHOD.