  METHOD bits_to_int.

    DATA: lv_c    TYPE c LENGTH 1,
          lv_bits TYPE string.

    lv_bits = iv_bits.

    WHILE NOT lv_bits IS INITIAL.
      lv_c = lv_bits.
      rv_int = rv_int * 2.
      rv_int = rv_int + lv_c.
      lv_bits = lv_bits+1.
    ENDWHILE.

  ENDMETHOD.