  METHOD delta_header.

    DATA: lv_bitbyte TYPE zif_abapgit_definitions=>ty_bitbyte,
          lv_bits    TYPE string,
          lv_x       TYPE x.


    lv_bits = ''.
    DO.
      lv_x = io_stream->eat_byte( ).
      lv_bitbyte = zcl_abapgit_convert=>x_to_bitbyte( lv_x ).
      CONCATENATE lv_bitbyte+1 lv_bits INTO lv_bits.
      IF lv_bitbyte(1) = '0'.
        EXIT. " current loop
      ENDIF.
    ENDDO.
    rv_header = zcl_abapgit_convert=>bitbyte_to_int( lv_bits ).

  ENDMETHOD.