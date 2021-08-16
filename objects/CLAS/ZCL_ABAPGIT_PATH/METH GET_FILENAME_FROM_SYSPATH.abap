  METHOD get_filename_from_syspath.

    DATA: lv_split TYPE c LENGTH 1,
          lv_index TYPE i,
          lt_split TYPE TABLE OF string.

    " filename | c:\filename | /dir/filename | \\server\filename
    IF iv_path CA '/'.
      lv_split = '/'.
    ELSE.
      lv_split = '\'.
    ENDIF.

    SPLIT iv_path AT lv_split INTO TABLE lt_split.

    lv_index = lines( lt_split ).

    READ TABLE lt_split INDEX lv_index INTO rv_filename.

  ENDMETHOD.