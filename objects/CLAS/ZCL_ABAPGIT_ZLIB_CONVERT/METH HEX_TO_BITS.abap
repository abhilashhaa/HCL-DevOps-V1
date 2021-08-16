  METHOD hex_to_bits.

    DATA: lv_x   TYPE x LENGTH 1,
          lv_c   TYPE c LENGTH 1,
          lv_bit TYPE i,
          lv_hex TYPE xstring.


    lv_hex = iv_hex.
    WHILE NOT lv_hex IS INITIAL.
      lv_x = lv_hex.
      DO 8 TIMES.
        lv_bit = sy-index.
        GET BIT lv_bit OF lv_x INTO lv_c.
        CONCATENATE rv_bits lv_c INTO rv_bits.
      ENDDO.
      lv_hex = lv_hex+1.
    ENDWHILE.

  ENDMETHOD.