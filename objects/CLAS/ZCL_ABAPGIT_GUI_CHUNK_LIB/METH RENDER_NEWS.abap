  METHOD render_news.

    DATA: lv_text TYPE string,
          lv_hint TYPE string,
          lt_log  TYPE zcl_abapgit_news=>tt_log.

    FIELD-SYMBOLS: <ls_line> LIKE LINE OF lt_log.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF io_news IS NOT BOUND OR io_news->has_news( ) = abap_false.
      RETURN.
    ENDIF.

    lt_log = io_news->get_log( ).

    " Render news
    LOOP AT lt_log ASSIGNING <ls_line>.
      IF <ls_line>-is_header = abap_true.
        IF <ls_line>-pos_to_cur > 0.
          lv_text = <ls_line>-text && '<span class="version-marker update">update</span>'.
        ELSEIF <ls_line>-pos_to_cur = 0.
          lv_text = <ls_line>-text && '<span class="version-marker">current</span>'.
        ELSE. " < 0
          lv_text = <ls_line>-text.
        ENDIF.
        ri_html->add( |<h1>{ lv_text }</h1>| ).
      ELSE.
        ri_html->add( |<li>{ <ls_line>-text }</li>| ).
      ENDIF.
    ENDLOOP.

    " Wrap
    IF io_news->has_important( ) = abap_true.
      lv_hint = 'Please note changes marked with "!"'.
    ENDIF.

    ri_html = render_infopanel(
      iv_div_id  = 'news'
      iv_title   = 'Announcement of the latest changes'
      iv_hint    = lv_hint
      iv_hide    = boolc( io_news->has_unseen( ) = abap_false )
      io_content = ri_html ).

  ENDMETHOD.