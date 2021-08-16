METHOD GET_WHERE_COND_FROM_SEL_CRIT.

  CLEAR: et_where_condition.

  mo_selection_util->free_selections_range_2_where(
    EXPORTING
      field_ranges  = it_selection_criteria
    IMPORTING
      where_clauses = et_where_condition
  ).

ENDMETHOD.