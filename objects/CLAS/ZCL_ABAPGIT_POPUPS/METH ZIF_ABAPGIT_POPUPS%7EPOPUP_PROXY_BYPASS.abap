  METHOD zif_abapgit_popups~popup_proxy_bypass.
    rt_proxy_bypass = it_proxy_bypass.
    CALL FUNCTION 'COMPLEX_SELECTIONS_DIALOG'
      EXPORTING
        title             = 'Bypass proxy settings for these Hosts & Domains'
        signed            = abap_false
        lower_case        = abap_true
        no_interval_check = abap_true
      TABLES
        range             = rt_proxy_bypass
      EXCEPTIONS
        no_range_tab      = 1
        cancelled         = 2
        internal_error    = 3
        invalid_fieldname = 4
        OTHERS            = 5.
    CASE sy-subrc.
      WHEN 0.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_abapgit_cancel.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( 'Error from COMPLEX_SELECTIONS_DIALOG' ).
    ENDCASE.
  ENDMETHOD.