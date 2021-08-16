  METHOD constructor.

    super->constructor( ).
    mv_order_by = |NAME|.

    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone            = mv_time_zone
      EXCEPTIONS
        customizing_missing = 1
        OTHERS              = 2.
    ASSERT sy-subrc = 0.

  ENDMETHOD.