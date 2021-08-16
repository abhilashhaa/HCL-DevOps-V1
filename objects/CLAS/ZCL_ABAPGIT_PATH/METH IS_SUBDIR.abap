  METHOD is_subdir.

    DATA lv_len  TYPE i.
    DATA lv_last TYPE i.

    lv_len  = strlen( iv_parent ).
    lv_last = lv_len - 1.
    rv_yes  = boolc( strlen( iv_path ) > lv_len
                 AND iv_path+0(lv_len) = iv_parent
                 AND ( iv_parent+lv_last(1) = '/' OR iv_path+lv_len(1) = '/' ) ).

  ENDMETHOD.