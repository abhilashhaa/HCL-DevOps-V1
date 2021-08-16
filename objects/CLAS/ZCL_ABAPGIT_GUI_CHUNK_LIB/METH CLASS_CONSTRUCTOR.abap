  METHOD class_constructor.

    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone            = gv_time_zone
      EXCEPTIONS
        customizing_missing = 1
        OTHERS              = 2.
    ASSERT sy-subrc = 0.

  ENDMETHOD.