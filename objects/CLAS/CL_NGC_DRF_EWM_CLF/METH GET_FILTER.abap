METHOD get_filter.
  IF mo_filter IS NOT BOUND.
    mo_filter = NEW cl_ngc_drf_ewm_clf_filter( ).
  ENDIF.

  ro_filter = mo_filter.
ENDMETHOD.