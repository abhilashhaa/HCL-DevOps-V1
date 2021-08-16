  METHOD map_distance.

    CASE iv_code.
      WHEN 0.
        rv_distance = go_stream->take_int( 0 ) + 1.
      WHEN 1.
        rv_distance = go_stream->take_int( 0 ) + 2.
      WHEN 2.
        rv_distance = go_stream->take_int( 0 ) + 3.
      WHEN 3.
        rv_distance = go_stream->take_int( 0 ) + 4.
      WHEN 4.
        rv_distance = go_stream->take_int( 1 ) + 5.
      WHEN 5.
        rv_distance = go_stream->take_int( 1 ) + 7.
      WHEN 6.
        rv_distance = go_stream->take_int( 2 ) + 9.
      WHEN 7.
        rv_distance = go_stream->take_int( 2 ) + 13.
      WHEN 8.
        rv_distance = go_stream->take_int( 3 ) + 17.
      WHEN 9.
        rv_distance = go_stream->take_int( 3 ) + 25.
      WHEN 10.
        rv_distance = go_stream->take_int( 4 ) + 33.
      WHEN 11.
        rv_distance = go_stream->take_int( 4 ) + 49.
      WHEN 12.
        rv_distance = go_stream->take_int( 5 ) + 65.
      WHEN 13.
        rv_distance = go_stream->take_int( 5 ) + 97.
      WHEN 14.
        rv_distance = go_stream->take_int( 6 ) + 129.
      WHEN 15.
        rv_distance = go_stream->take_int( 6 ) + 193.
      WHEN 16.
        rv_distance = go_stream->take_int( 7 ) + 257.
      WHEN 17.
        rv_distance = go_stream->take_int( 7 ) + 385.
      WHEN 18.
        rv_distance = go_stream->take_int( 8 ) + 513.
      WHEN 19.
        rv_distance = go_stream->take_int( 8 ) + 769.
      WHEN 20.
        rv_distance = go_stream->take_int( 9 ) + 1025.
      WHEN 21.
        rv_distance = go_stream->take_int( 9 ) + 1537.
      WHEN 22.
        rv_distance = go_stream->take_int( 10 ) + 2049.
      WHEN 23.
        rv_distance = go_stream->take_int( 10 ) + 3073.
      WHEN 24.
        rv_distance = go_stream->take_int( 11 ) + 4097.
      WHEN 25.
        rv_distance = go_stream->take_int( 11 ) + 6145.
      WHEN 26.
        rv_distance = go_stream->take_int( 12 ) + 8193.
      WHEN 27.
        rv_distance = go_stream->take_int( 12 ) + 12289.
      WHEN 28.
        rv_distance = go_stream->take_int( 13 ) + 16385.
      WHEN 29.
        rv_distance = go_stream->take_int( 13 ) + 24577.
      WHEN OTHERS.
        ASSERT 1 = 0.
    ENDCASE.

  ENDMETHOD.