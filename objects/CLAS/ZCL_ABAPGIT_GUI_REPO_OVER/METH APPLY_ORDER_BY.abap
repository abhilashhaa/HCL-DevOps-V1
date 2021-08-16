  METHOD apply_order_by.

    DATA:
      lt_sort TYPE abap_sortorder_tab,
      ls_sort LIKE LINE OF lt_sort.

    ls_sort-name = 'FAVORITE'.
    ls_sort-descending = abap_true.
    ls_sort-astext = abap_true.
    INSERT ls_sort INTO TABLE lt_sort.

    IF mv_order_by IS NOT INITIAL.

      ls_sort-name       = mv_order_by.
      ls_sort-descending = mv_order_descending.
      ls_sort-astext     = abap_true.
      INSERT ls_sort INTO TABLE lt_sort.
    ENDIF.

    SORT ct_overview BY (lt_sort).


  ENDMETHOD.