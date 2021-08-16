  METHOD precheck_dates.
    IF iv_datuv > iv_datub.
      RAISE EXCEPTION TYPE cx_ngc_core_cls_hier_maint
        EXPORTING
          textid     = cx_ngc_core_cls_hier_maint=>invalid_date_interval
          valid_from = iv_datuv
          valid_to   = iv_datub
          table_name = iv_table_name.
    ENDIF.
  ENDMETHOD.