  METHOD translate_postdata.

    DATA: lt_post_data       TYPE cnht_post_data_tab,
          ls_last_line       TYPE cnht_post_data_line,
          lv_last_line_index TYPE i.

    IF it_postdata IS INITIAL.
      RETURN. "Nothing to do
    ENDIF.

    lt_post_data = it_postdata.

    "Save the last line for separate merge, because we don't need its trailing spaces
    WHILE ls_last_line IS INITIAL.
      lv_last_line_index = lines( lt_post_data ).
      READ TABLE lt_post_data INTO ls_last_line INDEX lv_last_line_index.
      DELETE lt_post_data INDEX lv_last_line_index.
    ENDWHILE.

    CONCATENATE LINES OF lt_post_data INTO rv_string
      IN CHARACTER MODE RESPECTING BLANKS.
    CONCATENATE rv_string ls_last_line INTO rv_string
      IN CHARACTER MODE.

  ENDMETHOD.