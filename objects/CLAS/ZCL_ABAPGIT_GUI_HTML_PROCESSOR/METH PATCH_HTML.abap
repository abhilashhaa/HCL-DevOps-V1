  METHOD patch_html.

    CONSTANTS lc_css_re TYPE string VALUE `<link\s+rel="stylesheet"\s+type="text/css"\s+href="(\S+)">`.

    DATA lv_head_end TYPE i.
    DATA lo_css_re   TYPE REF TO cl_abap_regex.
    DATA lo_matcher  TYPE REF TO cl_abap_matcher.
    DATA lv_css_path TYPE string.
    DATA lv_marker   TYPE string.

    DATA lv_off TYPE i.
    DATA lv_len TYPE i.
    DATA lv_cur TYPE i.

    DATA lv_css_build TYPE string VALUE '<link rel="stylesheet" type="text/css" href="$BUILD_NAME">'.
    REPLACE FIRST OCCURRENCE OF '$BUILD_NAME' IN lv_css_build WITH c_css_build_name. " Mmmm

    CLEAR: ev_html, et_css_urls.

    lv_head_end = find_head_offset( iv_html ).

    CREATE OBJECT lo_css_re
      EXPORTING
        ignore_case = abap_true
        pattern     = lc_css_re.

    lo_matcher = lo_css_re->create_matcher( text = substring( val = iv_html len = lv_head_end ) ).
    WHILE lo_matcher->find_next( ) = abap_true.
      lv_css_path = lo_matcher->get_submatch( 1 ).
      IF abap_false = is_preserved( lv_css_path ).
        lv_off = lo_matcher->get_offset( ).
        lv_len = lo_matcher->get_length( ).
        ev_html = ev_html && substring( val = iv_html
                                        off = lv_cur
                                        len = lv_off - lv_cur ).
        ev_html = ev_html && c_comment_start && substring( val = iv_html
                                                           off = lv_off
                                                           len = lv_len ) && c_comment_end.
        lv_cur  = lv_off + lv_len.
        APPEND lv_css_path TO et_css_urls.
      ENDIF.
    ENDWHILE.

    ev_html = ev_html && substring( val = iv_html
                                    off = lv_cur
                                    len = lv_head_end - lv_cur ).
    IF lines( et_css_urls ) > 0.
      lv_marker = cl_abap_char_utilities=>newline
        && `    ` " Assume 4 space indent, maybe improve and detect ?
        && c_preprocess_marker
        && cl_abap_char_utilities=>newline
        && `    `.
      ev_html = ev_html && lv_marker && lv_css_build.
    ENDIF.
    ev_html = ev_html && substring( val = iv_html
                                    off = lv_head_end ).

  ENDMETHOD.