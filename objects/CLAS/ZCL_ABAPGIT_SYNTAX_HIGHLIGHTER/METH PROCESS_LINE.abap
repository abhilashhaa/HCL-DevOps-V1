  METHOD process_line.

    DATA: lt_matches TYPE ty_match_tt.

    IF iv_line IS INITIAL OR is_whitespace( iv_line ) = abap_true.
      rv_line = iv_line.
      RETURN.
    ENDIF.

    lt_matches = me->parse_line( iv_line ).

    me->order_matches( EXPORTING iv_line    = iv_line
                       CHANGING  ct_matches = lt_matches ).

    me->extend_matches( EXPORTING iv_line    = iv_line
                        CHANGING  ct_matches = lt_matches ).

    rv_line = me->format_line( iv_line    = iv_line
                               it_matches = lt_matches ).

  ENDMETHOD.