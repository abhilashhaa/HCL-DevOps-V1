  METHOD split_file_location.

    DATA: lv_cnt TYPE i,
          lv_len TYPE i.

    FIND FIRST OCCURRENCE OF REGEX '^/(.*/)?' IN iv_fullpath
      MATCH COUNT lv_cnt
      MATCH LENGTH lv_len.

    IF lv_cnt > 0.
      ev_path     = iv_fullpath+0(lv_len).
      ev_filename = iv_fullpath+lv_len.
    ELSE.
      CLEAR ev_path.
      ev_filename = iv_fullpath.
    ENDIF.

    ev_filename = cl_http_utility=>unescape_url( escaped = ev_filename ).

  ENDMETHOD.