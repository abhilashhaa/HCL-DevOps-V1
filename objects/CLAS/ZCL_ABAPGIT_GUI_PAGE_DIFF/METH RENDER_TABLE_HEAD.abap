  METHOD render_table_head.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( '<thead class="header">' ).
    ri_html->add( '<tr>' ).

    IF mv_unified = abap_true.

      render_table_head_unified( ri_html ).

    ELSE.

      render_table_head_non_unified(
          ii_html = ri_html
          is_diff = is_diff ).

    ENDIF.

    ri_html->add( '</tr>' ).
    ri_html->add( '</thead>' ).

  ENDMETHOD.