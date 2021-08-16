  METHOD get_instance.

    IF go_db IS NOT BOUND.
      CREATE OBJECT go_db.
    ENDIF.
    ro_db = go_db.

  ENDMETHOD.