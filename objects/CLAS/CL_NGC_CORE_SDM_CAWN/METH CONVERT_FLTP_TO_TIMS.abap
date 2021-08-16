  METHOD convert_fltp_to_tims.

    DATA:
      lv_pack(16) TYPE p.

    TRY.
        lv_pack = iv_fltp_value.
        UNPACK lv_pack TO rv_tims.

      CATCH cx_root INTO DATA(lx_exception).
        MESSAGE e099(sdmi) WITH iv_atnam iv_fltp_value lx_exception->get_text( ) INTO me->mo_logger->mv_logmsg.
        me->mo_logger->add_error( ).
    ENDTRY.

  ENDMETHOD.