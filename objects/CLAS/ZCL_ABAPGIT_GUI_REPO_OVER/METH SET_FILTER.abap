  METHOD set_filter.

    FIELD-SYMBOLS: <lv_postdata> LIKE LINE OF it_postdata.

    READ TABLE it_postdata ASSIGNING <lv_postdata>
                           INDEX 1.
    IF sy-subrc = 0.
      FIND FIRST OCCURRENCE OF REGEX `filter=(.*)`
           IN <lv_postdata>
           SUBMATCHES mv_filter.
    ENDIF.

    mv_filter = condense( mv_filter ).

  ENDMETHOD.