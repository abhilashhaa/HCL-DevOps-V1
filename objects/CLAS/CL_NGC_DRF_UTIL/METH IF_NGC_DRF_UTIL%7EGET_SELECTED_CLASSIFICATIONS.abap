METHOD IF_NGC_DRF_UTIL~GET_SELECTED_CLASSIFICATIONS.

  CLEAR: et_clf_key.

  me->get_where_cond_from_sel_crit(
    EXPORTING
      it_selection_criteria = it_selection_criteria
    IMPORTING
      et_where_condition    = DATA(lt_where_condition) ).

  get_selected_classifications(
    EXPORTING
      it_where_condition    = lt_where_condition
      it_selection_criteria = it_selection_criteria
    IMPORTING
      et_clf_key            = et_clf_key ).

ENDMETHOD.