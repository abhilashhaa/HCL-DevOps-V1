  METHOD change_dir.

    DATA: lv_last TYPE i,
          lv_temp TYPE string.

    lv_last = strlen( iv_cur_dir ) - 1.

    IF iv_cd = '' OR iv_cd = '.'. " No change
      rv_path = iv_cur_dir.
    ELSEIF iv_cd+0(1) = '/'.      " Absolute path
      rv_path = iv_cd.
    ELSEIF iv_cd = '..'.          " CD back
      IF iv_cur_dir = '/' OR iv_cur_dir = ''. " Back from root = root
        rv_path = iv_cur_dir.
      ELSE.
        lv_temp = reverse( iv_cur_dir ).
        IF lv_temp+0(1) = '/'.
          SHIFT lv_temp BY 1 PLACES LEFT.
        ENDIF.
        SHIFT lv_temp UP TO '/' LEFT.
        rv_path = reverse( lv_temp ).
      ENDIF.
    ELSEIF iv_cur_dir+lv_last(1) = '/'.  " Append cd to cur_dir separated by /
      rv_path = iv_cur_dir && iv_cd.
    ELSE.
      rv_path = iv_cur_dir && '/' && iv_cd.
    ENDIF.

    " TODO: improve logic and cases

  ENDMETHOD.