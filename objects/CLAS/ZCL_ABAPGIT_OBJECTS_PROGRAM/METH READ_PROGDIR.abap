  METHOD read_progdir.

    DATA: ls_sapdir TYPE progdir.


    CALL FUNCTION 'READ_PROGDIR'
      EXPORTING
        i_progname = iv_program
        i_state    = 'A'
      IMPORTING
        e_progdir  = ls_sapdir.
    MOVE-CORRESPONDING ls_sapdir TO rs_progdir.

    CLEAR: rs_progdir-edtx,
           rs_progdir-cnam,
           rs_progdir-cdat,
           rs_progdir-unam,
           rs_progdir-udat,
           rs_progdir-levl,
           rs_progdir-vern,
           rs_progdir-rmand,
           rs_progdir-sdate,
           rs_progdir-stime,
           rs_progdir-idate,
           rs_progdir-itime,
           rs_progdir-varcl,
           rs_progdir-state.

  ENDMETHOD.