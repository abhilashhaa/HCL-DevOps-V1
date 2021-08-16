  METHOD constructor.

    DATA: lt_delta TYPE vxabapt255_tab,
          lt_new   TYPE abaptxt255_tab,
          lt_old   TYPE abaptxt255_tab.


    unpack( EXPORTING iv_new = iv_new
                      iv_old = iv_old
            IMPORTING et_new = lt_new
                      et_old = lt_old ).

    lt_delta = compute( it_new = lt_new
                        it_old = lt_old ).

    mt_diff = render( it_new   = lt_new
                      it_old   = lt_old
                      it_delta = lt_delta ).

    calculate_line_num_and_stats( ).
    map_beacons( ).
    shortlist( ).

  ENDMETHOD.