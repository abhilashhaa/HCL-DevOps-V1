  METHOD zif_abapgit_gui_services~cache_asset.

    DATA: lt_xdata TYPE lvc_t_mime,
          lv_size  TYPE i,
          lt_html  TYPE w3htmltab.

    ASSERT iv_text IS SUPPLIED OR iv_xdata IS SUPPLIED.

    IF iv_text IS SUPPLIED. " String input
      zcl_abapgit_convert=>string_to_tab(
         EXPORTING
           iv_str  = iv_text
         IMPORTING
           ev_size = lv_size
           et_tab  = lt_html ).

      mi_html_viewer->load_data(
        EXPORTING
          iv_type         = iv_type
          iv_subtype      = iv_subtype
          iv_size         = lv_size
          iv_url          = iv_url
        IMPORTING
          ev_assigned_url = rv_url
        CHANGING
          ct_data_table   = lt_html
        EXCEPTIONS
          OTHERS          = 1 ).
    ELSE. " Raw input
      zcl_abapgit_convert=>xstring_to_bintab(
        EXPORTING
          iv_xstr   = iv_xdata
        IMPORTING
          ev_size   = lv_size
          et_bintab = lt_xdata ).

      mi_html_viewer->load_data(
        EXPORTING
          iv_type         = iv_type
          iv_subtype      = iv_subtype
          iv_size         = lv_size
          iv_url          = iv_url
        IMPORTING
          ev_assigned_url = rv_url
        CHANGING
          ct_data_table   = lt_xdata
        EXCEPTIONS
          OTHERS          = 1 ).
    ENDIF.

    ASSERT sy-subrc = 0. " Image data error

  ENDMETHOD.