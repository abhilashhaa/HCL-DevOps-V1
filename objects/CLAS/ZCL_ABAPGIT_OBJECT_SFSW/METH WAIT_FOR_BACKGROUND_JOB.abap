  METHOD wait_for_background_job.

    DATA: lv_job_count TYPE tbtco-jobcount.

    " We wait for at most 5 seconds. If it takes
    " more than that it probably doesn't matter,
    " because we have other problems

    DO 5 TIMES.

      SELECT SINGLE jobcount
        FROM tbtco
        INTO lv_job_count
        WHERE jobname = 'SFW_DELETE_SWITCH'
        AND status = 'R'
        AND sdluname = sy-uname.

      IF sy-subrc = 0.
        WAIT UP TO 1 SECONDS.
      ELSE.
        EXIT.
      ENDIF.

    ENDDO.

  ENDMETHOD.