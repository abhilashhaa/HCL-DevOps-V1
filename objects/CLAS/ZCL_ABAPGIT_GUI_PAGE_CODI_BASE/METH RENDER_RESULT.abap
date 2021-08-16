  METHOD render_result.

    CONSTANTS: lc_limit TYPE i VALUE 500.
    FIELD-SYMBOLS: <ls_result> TYPE scir_alvlist.

    ii_html->add( '<div class="ci-result">' ).

    LOOP AT it_result ASSIGNING <ls_result> TO lc_limit.
      render_result_line(
        ii_html = ii_html
        is_result = <ls_result> ).
    ENDLOOP.

    ii_html->add( '</div>' ).

    IF lines( it_result ) > lc_limit.
      ii_html->add( '<div class="dummydiv warning">' ).
      ii_html->add( ii_html->icon( 'exclamation-triangle' ) ).
      ii_html->add( |Only first { lc_limit } findings shown in list!| ).
      ii_html->add( '</div>' ).
    ENDIF.

  ENDMETHOD.