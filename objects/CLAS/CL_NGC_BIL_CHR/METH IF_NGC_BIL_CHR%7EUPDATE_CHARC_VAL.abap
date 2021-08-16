  METHOD if_ngc_bil_chr~update_charc_val.

    FIELD-SYMBOLS:
      <ls_change_data>   TYPE lty_s_charc_data,
      <ls_charc_val_api> TYPE lty_s_charcval_create.


    CLEAR: et_failed, et_reported.


    LOOP AT it_update ASSIGNING FIELD-SYMBOL(<ls_update>).
      UNASSIGN: <ls_change_data>, <ls_charc_val_api>.

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
        me->add_charc_val_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_position_number      = <ls_update>-charcvaluepositionnumber
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).
        CONTINUE.
      ENDIF.

      IF <ls_change_data> IS NOT ASSIGNED.
        " Characteristic does not exist
        MESSAGE e026(ngc_rap) INTO lv_message.
        me->add_charc_val_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_position_number      = <ls_update>-charcvaluepositionnumber
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).

        CONTINUE.
      ENDIF.

      IF <ls_update>-isdefaultvalue = abap_true AND
         <ls_change_data>-charc-value_assignment = 'S' AND
         line_exists( <ls_change_data>-charcval[ default_value = abap_true ] ).
        " A default characteristic value already exists
        MESSAGE e023(ngc_rap) INTO lv_message.
        me->add_charc_val_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_position_number      = <ls_update>-charcvaluepositionnumber
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).

        CONTINUE.
      ENDIF.

*      IF ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-char AND
*           line_exists( <ls_change_data>-charcval[ value_char = <ls_update>-charcvalue ] ) ) OR
*         ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-num AND
*           line_exists( <ls_change_data>-charcval[
*             value_from = <ls_update>-charcfromnumericvalue
*             value_to   = <ls_update>-charctonumericvalue
*             unit_from  = <ls_update>-charcfromnumericvalueunit
*             unit_to    = <ls_update>-charctonumericvalueunit ] ) ) OR
*         ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-curr AND
*           line_exists( <ls_change_data>-charcval[
*             value_from    = <ls_update>-charcfromnumericvalue
*             value_to      = <ls_update>-charctonumericvalue
*             currency_from = <ls_update>-charcfromnumericvalueunit
*             currency_to   = <ls_update>-charctonumericvalueunit ] ) ) OR
*         ( ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-date OR
*             <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-time ) AND
*           line_exists( <ls_change_data>-charcval[
*             value_from    = <ls_update>-charcfromnumericvalue
*             value_to      = <ls_update>-charctonumericvalue ] ) ) .
*        " Characteristic value already exists
*        MESSAGE e020(ngc_rap) INTO lv_message.
*        me->add_charc_val_message(
*          EXPORTING
*            iv_root_charcinternalid = <ls_update>-charcinternalid
*            iv_charcinternalid      = <ls_update>-charcinternalid
*            iv_position_number      = <ls_update>-charcvaluepositionnumber
*            iv_cid                  = <ls_update>-%cid_ref
*            iv_set_failed           = abap_true
*            iv_new                  = lv_new
*          CHANGING
*            ct_reported             = et_reported
*            ct_failed               = et_failed ).
*
*        CONTINUE.
*      ENDIF.

      " Execute checks
      DATA(ls_change_data) = <ls_change_data>.
      ASSIGN ls_change_data-charcval[ charcvaluepositionnumber = <ls_update>-charcvaluepositionnumber ] TO <ls_charc_val_api>.

      IF <ls_charc_val_api> IS NOT ASSIGNED.
        IF lv_new = abap_true.
          DELETE mt_charc_change_data
            WHERE
              charc-charcinternalid = <ls_update>-charcinternalid.
        ENDIF.

        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid          = <ls_update>-charcinternalid.
        <ls_failed>-charcvaluepositionnumber = <ls_update>-charcvaluepositionnumber.
        <ls_failed>-%cid                     = <ls_update>-%cid_ref.

        UNASSIGN: <ls_change_data>, <ls_charc_val_api>.

        CONTINUE.
      ENDIF.

      DATA(ls_charc_val_api) = me->map_charc_val_vdm_api(
        is_charc_val_vdm_upd = <ls_update>
        is_charc_val_api     = <ls_charc_val_api>
        is_charc_api         = <ls_change_data>-charc ).

      IF ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-char AND
           line_exists( <ls_change_data>-charcval[ value_char = ls_charc_val_api-charcvalue ] ) ) OR
         ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-num AND
           line_exists( <ls_change_data>-charcval[
             value_from     = ls_charc_val_api-value_from
             value_to       = ls_charc_val_api-value_to
             unit_from      = ls_charc_val_api-unit_from
             unit_to        = ls_charc_val_api-unit_to
             value_relation = ls_charc_val_api-value_relation ] ) ) OR
         ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-curr AND
           line_exists( <ls_change_data>-charcval[
             value_from     = ls_charc_val_api-value_from
             value_to       = ls_charc_val_api-value_to
             currency_from  = ls_charc_val_api-currency_from
             currency_to    = ls_charc_val_api-currency_to
             value_relation = ls_charc_val_api-value_relation ] ) ) OR
         ( ( <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-date OR
             <ls_change_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-time ) AND
           line_exists( <ls_change_data>-charcval[
             value_from     = ls_charc_val_api-value_from
             value_to       = ls_charc_val_api-value_to
             value_relation = ls_charc_val_api-value_relation ] ) ) .
        " Characteristic value already exists
        MESSAGE e020(ngc_rap) INTO lv_message.
        me->add_charc_val_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_position_number      = <ls_update>-charcvaluepositionnumber
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).

        CONTINUE.
      ENDIF.

      LOOP AT ls_change_data-charcvaldesc ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc>)
        WHERE
          value_char = <ls_charc_val_api>-value_char.
        <ls_charc_val_desc>-value_char = ls_charc_val_api-value_char.
      ENDLOOP.

      <ls_charc_val_api> = CORRESPONDING #( ls_charc_val_api ).

      DATA(lt_return) = me->modify_charc_data( ls_change_data ).

      CALL FUNCTION 'CTMV_CHARACT_INIT'.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_charc_val_message(
          EXPORTING
            iv_root_charcinternalid = <ls_update>-charcinternalid
            iv_charcinternalid      = <ls_update>-charcinternalid
            iv_position_number      = <ls_update>-charcvaluepositionnumber
            iv_cid                  = <ls_update>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
            is_bapiret              = <ls_return>
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_change_data> = ls_change_data.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.