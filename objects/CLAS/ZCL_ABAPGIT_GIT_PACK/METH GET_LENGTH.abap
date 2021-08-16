  METHOD get_length.

    DATA: lv_x           TYPE x,
          lv_length_bits TYPE string,
          lv_bitbyte     TYPE zif_abapgit_definitions=>ty_bitbyte.


    lv_x = cv_data(1).
    lv_bitbyte = zcl_abapgit_convert=>x_to_bitbyte( lv_x ).

    cv_data = cv_data+1.
    lv_length_bits = lv_bitbyte+4.

    WHILE lv_bitbyte(1) <> '0'.
      lv_x = cv_data(1).
      lv_bitbyte = zcl_abapgit_convert=>x_to_bitbyte( lv_x ).
      cv_data = cv_data+1.
      CONCATENATE lv_bitbyte+1 lv_length_bits INTO lv_length_bits.
    ENDWHILE.

    ev_length = zcl_abapgit_convert=>bitbyte_to_int( lv_length_bits ).

  ENDMETHOD.