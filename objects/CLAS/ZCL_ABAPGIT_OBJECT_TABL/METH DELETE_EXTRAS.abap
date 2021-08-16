  METHOD delete_extras.

    DELETE FROM tddat WHERE tabname = iv_tabname.

  ENDMETHOD.