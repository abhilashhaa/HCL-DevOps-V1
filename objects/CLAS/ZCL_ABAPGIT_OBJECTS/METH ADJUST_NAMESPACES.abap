  METHOD adjust_namespaces.

    FIELD-SYMBOLS: <ls_result> LIKE LINE OF rt_results.

    rt_results = it_results.

    LOOP AT rt_results ASSIGNING <ls_result>.
      REPLACE ALL OCCURRENCES OF '#' IN <ls_result>-obj_name WITH '/'.
    ENDLOOP.

  ENDMETHOD.