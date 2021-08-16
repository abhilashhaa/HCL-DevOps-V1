  METHOD is_idoc_segment.

    DATA lv_segment_type TYPE edilsegtyp.

    lv_segment_type = ms_item-obj_name.

    SELECT SINGLE segtyp
           FROM edisegment
           INTO lv_segment_type
           WHERE segtyp = lv_segment_type.
    rv_is_idoc_segment = boolc( sy-subrc = 0 ).

  ENDMETHOD.