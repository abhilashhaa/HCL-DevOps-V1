  METHOD if_ngc_bil_chr~update_charc.

    FIELD-SYMBOLS:
      <ls_change_data> TYPE lty_s_charc_data.


    CLEAR: et_failed, et_reported.


    LOOP AT it_update ASSIGNING FIELD-SYMBOL(<ls_update>).
      UNASSIGN <ls_change_data>.

      DATA(lv_new) = me->load_charc_data(
        iv_charcinternalid = <ls_update>-charcinternalid ).
*        iv_changenumber    = <ls_update>-changenumber ).
*      ASSIGN mt_charc_change_data[ charc-charcinternalid = <ls_update>-charcinternalid changenumber = <ls_update>-changenumber ] TO <ls_change_data>.
      ASSIGN mt_charc_change_data[ charc-charcinternalid = <ls_update>-charcinternalid ] TO <ls_change_data>.

*--------------------------------------------------------------------*
* Check change number
*--------------------------------------------------------------------*
      IF <ls_update>-changenumber IS NOT INITIAL.
        " Using a change number is not supported
        MESSAGE e047(ngc_rap) INTO DATA(lv_message).
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_update>-charcinternalid
            iv_cid             = <ls_update>-%cid_ref
            iv_set_failed      = abap_true
            iv_new             = lv_new
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      IF <ls_change_data> IS NOT ASSIGNED.
        " Characteristic does not exist
        MESSAGE e026(ngc_rap) INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_update>-charcinternalid
            iv_cid             = <ls_update>-%cid_ref
            iv_set_failed      = abap_true
            iv_new             = lv_new
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      IF <ls_update>-charcstatus IS INITIAL AND <ls_update>-%control-charcstatus = cl_abap_behavior_handler=>flag_changed.
        " Define a status for characteristic &1
        MESSAGE e015(ngc_rap) WITH <ls_update>-characteristic INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_update>-charcinternalid
            iv_cid             = <ls_update>-%cid_ref
            iv_set_failed      = abap_true
            iv_new             = lv_new
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      IF <ls_update>-charcdatatype          <> if_ngc_c=>gc_charcdatatype-char AND
         <ls_update>-charcdatatype          <> if_ngc_c=>gc_charcdatatype-curr AND
         <ls_update>-charcdatatype          <> if_ngc_c=>gc_charcdatatype-date AND
         <ls_update>-charcdatatype          <> if_ngc_c=>gc_charcdatatype-num AND
         <ls_update>-charcdatatype          <> if_ngc_c=>gc_charcdatatype-time AND
         <ls_update>-%control-charcdatatype =  cl_abap_behavior_handler=>flag_changed.
        " Data type &1 does not exist
        MESSAGE e010(ngc_rap) WITH <ls_update>-charcdatatype INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_update>-charcinternalid
            iv_cid             = <ls_update>-%cid_ref
            iv_set_failed      = abap_true
            iv_new             = lv_new
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      IF <ls_update>-charclength IS INITIAL AND <ls_update>-%control-charclength = cl_abap_behavior_handler=>flag_changed.
        " Characteristic length should be defined
        MESSAGE e040(ngc_rap) INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_update>-charcinternalid
            iv_cid             = <ls_update>-%cid_ref
            iv_set_failed      = abap_true
            iv_new             = lv_new
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      " Execute checks
      DATA(ls_change_data) = <ls_change_data>.

      DATA(ls_charc) = me->map_charc_vdm_api(
        is_charc_api     = ls_change_data-charc
        is_charc_vdm_upd = <ls_update> ).
      ls_change_data-charc = CORRESPONDING #( BASE ( ls_change_data-charc ) ls_charc EXCEPT charact_name ).

      IF ls_change_data-charc-data_type = if_ngc_c=>gc_charcdatatype-num.
        CLEAR: ls_change_data-charc-template, ls_change_data-charc-template_long.
      ENDIF.

      DATA(lt_return) = me->modify_charc_data( ls_change_data ).

      CALL FUNCTION 'CTMV_CHARACT_INIT'.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_update>-charcinternalid
            iv_cid             = <ls_update>-%cid_ref
            iv_set_failed      = abap_true
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_change_data> = ls_change_data.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.