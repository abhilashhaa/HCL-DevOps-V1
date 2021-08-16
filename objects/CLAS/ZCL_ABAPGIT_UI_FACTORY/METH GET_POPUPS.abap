  METHOD get_popups.

    IF gi_popups IS INITIAL.
      CREATE OBJECT gi_popups TYPE zcl_abapgit_popups.
    ENDIF.

    ri_popups = gi_popups.

  ENDMETHOD.