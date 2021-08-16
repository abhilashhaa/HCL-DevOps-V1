  METHOD read_pair.

    DATA: lv_symbol TYPE i.


    rs_pair-length = map_length( iv_length ).

    lv_symbol = decode( go_distcode ).
    rs_pair-distance = map_distance( lv_symbol ).

  ENDMETHOD.