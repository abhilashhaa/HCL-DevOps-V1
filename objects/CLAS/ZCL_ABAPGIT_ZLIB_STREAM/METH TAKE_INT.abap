  METHOD take_int.

    rv_int = zcl_abapgit_zlib_convert=>bits_to_int( take_bits( iv_length ) ).

  ENDMETHOD.