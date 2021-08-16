  METHOD checkbox.

    DATA: lv_checked TYPE string.

    IF iv_checked = abap_true.
      lv_checked = |checked|.
    ENDIF.

    rv_html = |<input type="checkbox" id="{ iv_id }" { lv_checked }>|.

  ENDMETHOD.