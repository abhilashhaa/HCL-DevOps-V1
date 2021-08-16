  METHOD adjust_inbound.

    FIELD-SYMBOLS: <ls_scprvals> TYPE scprvals,
                   <ls_scprreca> TYPE scprreca,
                   <ls_scprvall> TYPE scprvall.

* back to internal format
    LOOP AT cs_scp1-scprvals ASSIGNING <ls_scprvals>.
      SHIFT <ls_scprvals>-recnumber RIGHT DELETING TRAILING space.
    ENDLOOP.
    LOOP AT cs_scp1-scprreca ASSIGNING <ls_scprreca>.
      SHIFT <ls_scprreca>-recnumber RIGHT DELETING TRAILING space.
    ENDLOOP.
    LOOP AT cs_scp1-scprvall ASSIGNING <ls_scprvall>.
      SHIFT <ls_scprvall>-recnumber RIGHT DELETING TRAILING space.
    ENDLOOP.

  ENDMETHOD.