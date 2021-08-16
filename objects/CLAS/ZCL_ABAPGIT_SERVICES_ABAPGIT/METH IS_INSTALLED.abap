  METHOD is_installed.

    SELECT SINGLE devclass FROM tadir INTO rv_devclass
      WHERE pgmid = 'R3TR'
      AND object = 'CLAS'
      AND obj_name = c_abapgit_class.

  ENDMETHOD.