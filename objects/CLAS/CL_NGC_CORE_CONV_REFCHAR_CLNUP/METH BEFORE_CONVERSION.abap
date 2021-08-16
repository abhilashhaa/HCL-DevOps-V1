  METHOD before_conversion.

    DATA:
      lv_exists TYPE boole_d VALUE abap_false.

    IF mv_log2file = abap_true.
      mo_conv_logger->init_logger(
        iv_appl_name = mv_appl_name
        iv_logtype   = cl_upgba_logger=>gc_logtype_file
      ).
    ELSE.
      mo_conv_logger->init_logger(
        iv_appl_name = mv_appl_name
      ).
    ENDIF.

    " Ensure only privileged user are allowed to manually start the data conversion.
    rv_exit = xsdbool( mo_conv_util->is_authorized( ) = abap_false ).

    IF rv_exit = abap_true.
      mo_conv_logger->log_message(
        iv_id     = 'UPGBA'
        iv_type   = 'E'
        iv_number = '900'
      ) ##NO_TEXT.
      mo_conv_logger->close( ).
    ELSE.

      " First we have to set up our views.
      IF me->create_views( ) = abap_true.

        " Skip execution if no conversion relevant data in this system (optional).
        " Avoid use of COUNT(*) unless really necessary.
        IF lines( mtr_objek ) = 0.
          TEST-SEAM exists_1_seam.
            SELECT SINGLE @abap_true INTO @lv_exists FROM (gv_refchars_name). "#EC CI_DYNTAB
          END-TEST-SEAM.
        ELSE.
          TEST-SEAM exists_2_seam.
            SELECT SINGLE @abap_true INTO @lv_exists FROM (gv_refchars_name) WHERE objek IN @mtr_objek. "#EC CI_DYNTAB
          END-TEST-SEAM.
        ENDIF.

        IF lv_exists = abap_false.
          mo_conv_logger->log_message(
            iv_id     = 'UPGBA'
            iv_type   = 'I'
            iv_number = '034'
            iv_param1 = 'No relevant data found'
            iv_param2 = 'in this system. Client:'
            iv_param3 = CONV #( sy-mandt )
          ) ##NO_TEXT.

          me->delete_views( ).

          mo_conv_logger->close( ).

          rv_exit = abap_true.
        ENDIF.
      ELSE.
        mo_conv_logger->close( ).

        rv_exit = abap_true.
      ENDIF.
    ENDIF.

  ENDMETHOD.