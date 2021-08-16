  METHOD zif_abapgit_progress~show.

    DATA: lv_pct  TYPE i,
          lv_time TYPE t.

    CONSTANTS: lc_wait_secs TYPE i VALUE 2.

    GET TIME.
    lv_time = sy-uzeit.
    IF mv_cv_time_next IS INITIAL AND mv_cv_datum_next IS INITIAL.
      mv_cv_time_next  = lv_time.
      mv_cv_datum_next = sy-datum.
    ENDIF.

    "We only do a progress indication if enough time has passed
    IF lv_time >= mv_cv_time_next
        AND sy-datum = mv_cv_datum_next
        OR sy-datum > mv_cv_datum_next.

      lv_pct = calc_pct( iv_current ).

      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = lv_pct
          text       = iv_text.
      mv_cv_time_next = lv_time + lc_wait_secs.

    ENDIF.
    IF sy-datum > mv_cv_datum_next.
      mv_cv_datum_next = sy-datum.
    ENDIF.
    IF mv_cv_time_next < lv_time.
      mv_cv_datum_next = sy-datum + 1.
    ENDIF.

  ENDMETHOD.