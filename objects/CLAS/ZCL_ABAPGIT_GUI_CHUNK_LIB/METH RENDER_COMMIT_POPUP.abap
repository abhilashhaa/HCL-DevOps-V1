  METHOD render_commit_popup.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<ul class="hotkeys">' ).
    ri_html->add( |<li>| && |<span>{ iv_content }</span>| && |</li>| ).
    ri_html->add( '</ul>' ).

    ri_html = render_infopanel(
      iv_div_id     = |{ iv_id }|
      iv_title      = 'Commit details'
      iv_hide       = abap_true
      iv_scrollable = abap_false
      io_content    = ri_html ).

  ENDMETHOD.