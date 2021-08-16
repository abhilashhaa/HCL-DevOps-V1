  METHOD get_class_package.

    SELECT SINGLE devclass FROM tadir
      INTO rv_package
      WHERE pgmid = 'R3TR'
      AND object = 'CLAS'
      AND obj_name = iv_class_name.

  ENDMETHOD.