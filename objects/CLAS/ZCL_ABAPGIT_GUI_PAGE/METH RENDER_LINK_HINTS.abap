  METHOD render_link_hints.

    DATA: lv_link_hint_key TYPE c LENGTH 1.

    lv_link_hint_key = mo_settings->get_link_hint_key( ).

    IF mo_settings->get_link_hints_enabled( ) = abap_true AND lv_link_hint_key IS NOT INITIAL.

      ii_html->add( |activateLinkHints("{ lv_link_hint_key }");| ).
      ii_html->add( |setInitialFocusWithQuerySelector('a span', true);| ).
      ii_html->add( |enableArrowListNavigation();| ).

    ENDIF.

  ENDMETHOD.