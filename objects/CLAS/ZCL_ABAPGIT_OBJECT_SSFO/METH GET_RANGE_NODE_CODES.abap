  METHOD get_range_node_codes.

    DATA: ls_range_node_code TYPE LINE OF ty_string_range.

    IF me->gt_range_node_codes IS INITIAL.
      ls_range_node_code-sign   = 'I'.
      ls_range_node_code-option = 'EQ'.
      ls_range_node_code-low    = 'CODE'.
      INSERT ls_range_node_code INTO TABLE me->gt_range_node_codes.
      ls_range_node_code-low    = 'GTYPES'.
      INSERT ls_range_node_code INTO TABLE me->gt_range_node_codes.
      ls_range_node_code-low    = 'GCODING'.
      INSERT ls_range_node_code INTO TABLE me->gt_range_node_codes.
      ls_range_node_code-low    = 'FCODING'.
      INSERT ls_range_node_code INTO TABLE me->gt_range_node_codes.
    ENDIF.

    rt_range_node_codes = me->gt_range_node_codes.

  ENDMETHOD.