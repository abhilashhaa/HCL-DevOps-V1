  METHOD map_length.

    CASE iv_code.
      WHEN 257.
        rv_length = go_stream->take_int( 0 ) + 3.
      WHEN 258.
        rv_length = go_stream->take_int( 0 ) + 4.
      WHEN 259.
        rv_length = go_stream->take_int( 0 ) + 5.
      WHEN 260.
        rv_length = go_stream->take_int( 0 ) + 6.
      WHEN 261.
        rv_length = go_stream->take_int( 0 ) + 7.
      WHEN 262.
        rv_length = go_stream->take_int( 0 ) + 8.
      WHEN 263.
        rv_length = go_stream->take_int( 0 ) + 9.
      WHEN 264.
        rv_length = go_stream->take_int( 0 ) + 10.
      WHEN 265.
        rv_length = go_stream->take_int( 1 ) + 11.
      WHEN 266.
        rv_length = go_stream->take_int( 1 ) + 13.
      WHEN 267.
        rv_length = go_stream->take_int( 1 ) + 15.
      WHEN 268.
        rv_length = go_stream->take_int( 1 ) + 17.
      WHEN 269.
        rv_length = go_stream->take_int( 2 ) + 19.
      WHEN 270.
        rv_length = go_stream->take_int( 2 ) + 23.
      WHEN 271.
        rv_length = go_stream->take_int( 2 ) + 27.
      WHEN 272.
        rv_length = go_stream->take_int( 2 ) + 31.
      WHEN 273.
        rv_length = go_stream->take_int( 3 ) + 35.
      WHEN 274.
        rv_length = go_stream->take_int( 3 ) + 43.
      WHEN 275.
        rv_length = go_stream->take_int( 3 ) + 51.
      WHEN 276.
        rv_length = go_stream->take_int( 3 ) + 59.
      WHEN 277.
        rv_length = go_stream->take_int( 4 ) + 67.
      WHEN 278.
        rv_length = go_stream->take_int( 4 ) + 83.
      WHEN 279.
        rv_length = go_stream->take_int( 4 ) + 99.
      WHEN 280.
        rv_length = go_stream->take_int( 4 ) + 115.
      WHEN 281.
        rv_length = go_stream->take_int( 5 ) + 131.
      WHEN 282.
        rv_length = go_stream->take_int( 5 ) + 163.
      WHEN 283.
        rv_length = go_stream->take_int( 5 ) + 195.
      WHEN 284.
        rv_length = go_stream->take_int( 5 ) + 227.
      WHEN 285.
        rv_length = go_stream->take_int( 0 ) + 258.
      WHEN OTHERS.
        ASSERT 1 = 0.
    ENDCASE.

  ENDMETHOD.