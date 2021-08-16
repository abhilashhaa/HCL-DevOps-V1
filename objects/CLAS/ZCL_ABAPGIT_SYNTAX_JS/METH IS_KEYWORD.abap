  METHOD is_keyword.

    DATA lv_str TYPE string.

    lv_str = to_lower( iv_chunk ).
    READ TABLE gt_keywords WITH TABLE KEY keyword = lv_str TRANSPORTING NO FIELDS.
    rv_yes = boolc( sy-subrc = 0 ).

  ENDMETHOD.