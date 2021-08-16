  METHOD icon.

    DATA: lv_hint       TYPE string,
          lv_name       TYPE string,
          lv_color      TYPE string,
          lv_class      TYPE string,
          lv_large_icon TYPE string,
          lv_xpixel     TYPE i,
          lv_onclick    TYPE string.

    SPLIT iv_name AT '/' INTO lv_name lv_color.

    IF iv_hint IS NOT INITIAL.
      lv_hint  = | title="{ iv_hint }"|.
    ENDIF.
    IF iv_onclick IS NOT INITIAL.
      lv_onclick = | onclick="{ iv_onclick }"|.
    ENDIF.
    IF iv_class IS NOT INITIAL.
      lv_class = | { iv_class }|.
    ENDIF.
    IF lv_color IS NOT INITIAL.
      lv_color = | { lv_color }|.
    ENDIF.

    lv_xpixel = cl_gui_cfw=>compute_pixel_from_metric( x_or_y = 'X'
                                                       in = 1 ).
    IF lv_xpixel >= 2.
      lv_large_icon = ' large'.
    ENDIF.

    rv_str = |<i class="icon{ lv_large_icon } icon-{ lv_name }{ lv_color }|.
    rv_str = |{ rv_str }{ lv_class }"{ lv_onclick }{ lv_hint }></i>|.

  ENDMETHOD.