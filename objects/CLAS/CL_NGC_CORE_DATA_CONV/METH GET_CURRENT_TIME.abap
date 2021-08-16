  METHOD get_current_time.
    DATA:
      lv_datum TYPE char30,
      lv_uzeit TYPE char30.

    GET TIME.
    WRITE sy-datum TO lv_datum.
    WRITE sy-uzeit TO lv_uzeit.
    CONCATENATE lv_datum lv_uzeit INTO rv_time SEPARATED BY space.
  ENDMETHOD.