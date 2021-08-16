  METHOD CONVERT_FLTP_TO_TIME.

    DATA lv_pack(16) TYPE p.

    TRY.
        lv_pack = iv_fltp_value.
        UNPACK lv_pack TO rv_time.
      CATCH cx_sy_conversion_error.
        RAISE conversion_error.
    ENDTRY.

  ENDMETHOD.