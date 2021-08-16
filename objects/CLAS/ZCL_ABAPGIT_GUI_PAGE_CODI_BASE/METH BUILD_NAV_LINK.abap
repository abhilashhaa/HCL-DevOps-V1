  METHOD build_nav_link.

    rv_link = |{ c_ci_sig }| &&
      |{ is_result-objtype }{ is_result-objname }| &&
      |{ c_object_separator }{ is_result-sobjtype }{ is_result-sobjname }| &&
      |{ c_object_separator }{ is_result-line }|.

  ENDMETHOD.