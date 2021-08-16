  METHOD if_sdm_migration~migrate_data.

    DATA:
      lt_cawn_update     TYPE STANDARD TABLE OF cawn,
      lt_db_view         TYPE STANDARD TABLE OF p_clfnsdmcawn,
      lv_d34n_from       TYPE cawn_dec_from,
      lv_d34n_to         TYPE cawn_dec_to,
      lv_curr_from       TYPE cawn_curr_from,
      lv_curr_to         TYPE cawn_curr_to,
      lv_date_from       TYPE cawn_date_from,
      lv_date_to         TYPE cawn_date_to,
      lv_time_from       TYPE cawn_time_from,
      lv_time_to         TYPE cawn_time_to,
      lv_conv_error_from TYPE boole_d,
      lv_conv_error_to   TYPE boole_d.

    DATA(lv_where_clause) = NEW cl_shdb_pfw_selset( it_filter_condition )->get_where_clause( ).

    SELECT * FROM p_clfnsdmcawn
      WHERE (lv_where_clause)                          "#EC CI_DYNWHERE
      INTO CORRESPONDING FIELDS OF TABLE @lt_db_view.

    LOOP AT lt_db_view REFERENCE INTO DATA(lr_db_view).
      APPEND INITIAL LINE TO lt_cawn_update ASSIGNING FIELD-SYMBOL(<ls_cawn_update>).

      <ls_cawn_update> = CORRESPONDING #( lr_db_view->* ).

      CASE lr_db_view->chr_data_type.
        WHEN if_ngc_c=>gc_charcdatatype-num.
          CLEAR: lv_d34n_from, lv_d34n_to.

          IF lr_db_view->atflv IS NOT INITIAL.
            lv_d34n_from = me->convert_fltp_to_d34n(
              iv_atnam      = lr_db_view->atnam
              iv_fltp_value = lr_db_view->atflv
              iv_decimals   = lr_db_view->decimals
              iv_exponent        = lr_db_view->exponent
              iv_exp_disp_format = lr_db_view->exp_disp_format
              iv_buom            = lr_db_view->msehi
              iv_uom             = lr_db_view->atawe
            ).
          ENDIF.

          IF lr_db_view->atflb IS NOT INITIAL.
            lv_d34n_to = me->convert_fltp_to_d34n(
              iv_atnam      = lr_db_view->atnam
              iv_fltp_value = lr_db_view->atflb
              iv_decimals   = lr_db_view->decimals
              iv_exponent        = lr_db_view->exponent
              iv_exp_disp_format = lr_db_view->exp_disp_format
              iv_buom            = lr_db_view->msehi
              iv_uom             = lr_db_view->ataw1
            ).
          ENDIF.

          me->get_d34n_boundaries(
            EXPORTING
              iv_dec_from = lv_d34n_from
              iv_dec_to   = lv_d34n_to
              iv_atcod    = lr_db_view->atcod
              iv_anzst    = lr_db_view->length
              iv_anzdz    = lr_db_view->decimals
              iv_atvor    = lr_db_view->atvor
              iv_atdex    = lr_db_view->exp_disp_format
              iv_atdim    = lr_db_view->exponent
            IMPORTING
              ev_dec_from = <ls_cawn_update>-dec_from
              ev_dec_to   = <ls_cawn_update>-dec_to
          ).

        WHEN if_ngc_c=>gc_charcdatatype-curr.
          CLEAR: lv_curr_from, lv_curr_to.

          lv_conv_error_from = abap_false.
          IF lr_db_view->atflv IS NOT INITIAL.
            lv_curr_from = me->convert_fltp_to_curr(
              EXPORTING
                iv_atnam      = lr_db_view->atnam
                iv_fltp_value = lr_db_view->atflv
                iv_currency   = CONV waers_curc( lr_db_view->msehi )
              IMPORTING
                ev_error      = lv_conv_error_from
            ).
          ENDIF.

          lv_conv_error_to = abap_false.
          IF lr_db_view->atflb IS NOT INITIAL.
            lv_curr_to = me->convert_fltp_to_curr(
              EXPORTING
                iv_atnam      = lr_db_view->atnam
                iv_fltp_value = lr_db_view->atflb
                iv_currency   = CONV waers_curc( lr_db_view->msehi )
              IMPORTING
                ev_error      = lv_conv_error_to
            ).
          ENDIF.

          IF lv_conv_error_from = abap_false AND lv_conv_error_to = abap_false.

            me->get_curr_boundaries(
              EXPORTING
                iv_curr_from = lv_curr_from
                iv_curr_to   = lv_curr_to
                iv_atcod     = lr_db_view->atcod
                iv_anzst     = lr_db_view->length
                iv_atvor     = lr_db_view->atvor
              IMPORTING
                ev_curr_from = <ls_cawn_update>-curr_from
                ev_curr_to   = <ls_cawn_update>-curr_to
            ).

            <ls_cawn_update>-currency = lr_db_view->msehi.
          ENDIF.

        WHEN if_ngc_c=>gc_charcdatatype-date.
          CLEAR: lv_date_from, lv_date_to.

          IF lr_db_view->atflv IS NOT INITIAL.
            lv_date_from = me->convert_fltp_to_dats(
              iv_atnam      = lr_db_view->atnam
              iv_fltp_value = lr_db_view->atflv
            ).
          ENDIF.

          IF lr_db_view->atflb IS NOT INITIAL.
            lv_date_to = me->convert_fltp_to_dats(
              iv_atnam      = lr_db_view->atnam
              iv_fltp_value = lr_db_view->atflb
            ).
          ENDIF.

          me->get_date_boundaries(
            EXPORTING
              iv_date_from = lv_date_from
              iv_date_to   = lv_date_to
              iv_atcod     = lr_db_view->atcod
            IMPORTING
              ev_date_from = <ls_cawn_update>-date_from
              ev_date_to   = <ls_cawn_update>-date_to
          ).

        WHEN if_ngc_c=>gc_charcdatatype-time.
          CLEAR: lv_time_from, lv_time_to.

          IF lr_db_view->atflv IS NOT INITIAL.
            lv_time_from = me->convert_fltp_to_tims(
              iv_atnam      = lr_db_view->atnam
              iv_fltp_value = lr_db_view->atflv
            ).
          ENDIF.

          IF lr_db_view->atflb IS NOT INITIAL.
            lv_time_to = me->convert_fltp_to_tims(
              iv_atnam      = lr_db_view->atnam
              iv_fltp_value = lr_db_view->atflb
            ).
          ENDIF.

          me->get_time_boundaries(
            EXPORTING
              iv_time_from = lv_time_from
              iv_time_to   = lv_time_to
              iv_atcod     = lr_db_view->atcod
            IMPORTING
              ev_time_from = <ls_cawn_update>-time_from
              ev_time_to   = <ls_cawn_update>-time_to
          ).
      ENDCASE.

    ENDLOOP.

    IF lines( lt_cawn_update ) > 0.
      UPDATE cawn FROM TABLE @lt_cawn_update.

      IF sy-subrc = 0.
        MESSAGE i099(sdmi) WITH sy-dbcnt ` records converted in client ` sy-mandt INTO me->mo_logger->mv_logmsg ##NO_TEXT.
        me->mo_logger->add_message( ).
      ELSE.
        MESSAGE e099(sdmi) WITH 'Not all rows were updated' INTO me->mo_logger->mv_logmsg ##NO_TEXT.
        me->mo_logger->add_error( ).
      ENDIF.

    ENDIF.

    IF me->mv_test_mode = abap_true.
      ROLLBACK CONNECTION default.                     "#EC CI_ROLLBACK
    ENDIF.

    COMMIT WORK.

  ENDMETHOD.