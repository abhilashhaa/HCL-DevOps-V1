  METHOD is_keyword.

    DATA lv_str TYPE string.

    lv_str = to_upper( iv_chunk ).
    READ TABLE gt_keywords WITH KEY table_line = lv_str TRANSPORTING NO FIELDS.
    rv_yes = boolc( sy-subrc = 0 ).

  ENDMETHOD.