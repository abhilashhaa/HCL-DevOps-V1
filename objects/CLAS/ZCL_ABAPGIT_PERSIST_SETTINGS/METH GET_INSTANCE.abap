  METHOD get_instance.

    IF go_persist IS NOT BOUND.
      CREATE OBJECT go_persist.
    ENDIF.
    ro_settings = go_persist.

  ENDMETHOD.