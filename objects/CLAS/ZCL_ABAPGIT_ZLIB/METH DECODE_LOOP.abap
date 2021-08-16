  METHOD decode_loop.

    DATA lv_x TYPE x.
    DATA lv_symbol TYPE i.

    DO.
      lv_symbol = decode( go_lencode ).

      IF lv_symbol < 256.
        lv_x = zcl_abapgit_zlib_convert=>int_to_hex( lv_symbol ).
        CONCATENATE gv_out lv_x INTO gv_out IN BYTE MODE.
      ELSEIF lv_symbol = 256.
        EXIT.
      ELSE.
        copy_out( read_pair( lv_symbol ) ).
      ENDIF.

    ENDDO.

  ENDMETHOD.