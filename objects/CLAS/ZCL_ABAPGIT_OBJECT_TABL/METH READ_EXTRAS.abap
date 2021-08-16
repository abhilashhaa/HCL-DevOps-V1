  METHOD read_extras.

    SELECT SINGLE * FROM tddat INTO rs_tabl_extras-tddat WHERE tabname = iv_tabname.

  ENDMETHOD.