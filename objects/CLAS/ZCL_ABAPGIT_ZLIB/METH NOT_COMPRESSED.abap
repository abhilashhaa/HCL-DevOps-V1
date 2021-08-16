  METHOD not_compressed.

    DATA: lv_len  TYPE i,
          lv_nlen TYPE i ##NEEDED.

    go_stream->take_bits( 5 ).

    lv_len = go_stream->take_int( 16 ).
    lv_nlen = go_stream->take_int( 16 ).

    gv_out = go_stream->take_bytes( lv_len ).

  ENDMETHOD.