  METHOD render_content.

    DATA: lv_text LIKE LINE OF mt_text.

    run( ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div id="toc">' ).
    LOOP AT mt_text INTO lv_text.
      ri_html->add( '<pre>' && lv_text && '</pre><br>' ).
    ENDLOOP.
    ri_html->add( '</div>' ).

  ENDMETHOD.