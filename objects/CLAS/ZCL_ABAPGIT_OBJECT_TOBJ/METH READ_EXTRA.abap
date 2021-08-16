  METHOD read_extra.

    SELECT SINGLE * FROM tddat INTO rs_tobj-tddat WHERE tabname = iv_tabname.

    SELECT SINGLE * FROM tvdir INTO rs_tobj-tvdir WHERE tabname = iv_tabname.
    CLEAR: rs_tobj-tvdir-gendate, rs_tobj-tvdir-gentime, rs_tobj-tvdir-devclass.

    SELECT * FROM tvimf INTO TABLE rs_tobj-tvimf WHERE tabname = iv_tabname.

  ENDMETHOD.