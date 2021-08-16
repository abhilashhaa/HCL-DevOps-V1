  METHOD zif_abapgit_progress~set_total.

    mv_total = iv_total.

    CLEAR mv_cv_time_next.
    CLEAR mv_cv_datum_next.

  ENDMETHOD.