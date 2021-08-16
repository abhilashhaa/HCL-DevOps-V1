  METHOD parse_change_tag_type_request.

    FIELD-SYMBOLS: <lv_postdata> TYPE cnht_post_data_line.

    READ TABLE it_postdata ASSIGNING <lv_postdata>
                           INDEX 1.
    IF sy-subrc = 0.
      FIND FIRST OCCURRENCE OF REGEX `type=(.*)`
           IN <lv_postdata>
           SUBMATCHES mv_selected_type.
    ENDIF.

    mv_selected_type = condense( mv_selected_type ).

  ENDMETHOD.