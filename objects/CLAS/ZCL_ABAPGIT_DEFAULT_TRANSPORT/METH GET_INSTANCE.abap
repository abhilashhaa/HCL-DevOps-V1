  METHOD get_instance.

    IF go_instance IS NOT BOUND.
      CREATE OBJECT go_instance.
    ENDIF.

    ro_instance = go_instance.

  ENDMETHOD.