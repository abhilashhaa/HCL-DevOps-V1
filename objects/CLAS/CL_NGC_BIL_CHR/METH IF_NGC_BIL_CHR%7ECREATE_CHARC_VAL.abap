  METHOD if_ngc_bil_chr~create_charc_val.

    DATA:
      lv_positionnumber_tmp TYPE atzhl.

    FIELD-SYMBOLS:
      <ls_charc_create_data> TYPE lty_s_charc_data.


    CLEAR: et_failed, et_mapped, et_reported.


    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_charc_val>).
        UNASSIGN <ls_charc_create_data>.

        CLEAR: lv_positionnumber_tmp.

        me->get_ancestor_idx(
          EXPORTING
            iv_cid_ref      = <ls_create>-%cid_ref
*           iv_changenumber = <ls_charc_val>-changenumber
          IMPORTING
            ev_root_idx     = DATA(lv_root_idx) ).

        IF lv_root_idx IS INITIAL.
          DATA(lv_new) = me->load_charc_data(
            iv_charcinternalid = <ls_create>-charcinternalid ).
*            iv_changenumber    = <ls_charc_val>-changenumber ).
*          ASSIGN mt_charc_change_data[ charc-cid = <ls_create>-%cid_ref changenumber = <ls_charc_val>-changenumber ] TO <ls_charc_create_data>.
          ASSIGN mt_charc_change_data[ charc-cid = <ls_create>-%cid_ref ] TO <ls_charc_create_data>.
        ELSE.
          ASSIGN mt_charc_create_data[ lv_root_idx ] TO <ls_charc_create_data>.
        ENDIF.

*--------------------------------------------------------------------*
* Check change number
*--------------------------------------------------------------------*

        IF <ls_charc_val>-changenumber IS NOT INITIAL.
          " Using a change number is not supported
          MESSAGE e047(ngc_rap) INTO DATA(lv_message).
          me->add_charc_val_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val>-charcinternalid
              iv_position_number      = <ls_charc_val>-charcvaluepositionnumber
              iv_cid                  = <ls_charc_val>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF <ls_charc_create_data> IS ASSIGNED.
          lv_positionnumber_tmp = lines( <ls_charc_create_data>-charcval ).
        ENDIF.

        IF <ls_charc_create_data> IS NOT ASSIGNED.
          " Characteristic does not exist
          MESSAGE e026(ngc_rap) INTO lv_message.
          me->add_charc_val_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val>-charcinternalid
              iv_position_number      = <ls_charc_val>-charcvaluepositionnumber
              iv_cid                  = <ls_charc_val>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF <ls_charc_val>-isdefaultvalue = abap_true AND
           <ls_charc_create_data>-charc-value_assignment = 'S' AND
           line_exists( <ls_charc_create_data>-charcval[ default_value = abap_true ] ).
          " A default characteristic value already exists
          MESSAGE e023(ngc_rap) INTO lv_message.
          me->add_charc_val_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val>-charcinternalid
              iv_position_number      = <ls_charc_val>-charcvaluepositionnumber
              iv_cid                  = <ls_charc_val>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        lv_positionnumber_tmp = lv_positionnumber_tmp + 1.

        " Do VDM to API mapping
        DATA(ls_charc_val_vdm) = VALUE i_clfncharcvalforkeydatetp( ).
        ls_charc_val_vdm = CORRESPONDING #( <ls_charc_val> ).
        DATA(ls_charc_val_api) = me->map_charc_val_vdm_api(
          is_charc_val_vdm = ls_charc_val_vdm
          is_charc_api     = <ls_charc_create_data>-charc ).

        IF ( <ls_charc_create_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-char AND
           line_exists( <ls_charc_create_data>-charcval[ value_char = ls_charc_val_api-charcvalue ] ) ) OR
         ( <ls_charc_create_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-num AND
           line_exists( <ls_charc_create_data>-charcval[
             value_from     = ls_charc_val_api-value_from
             value_to       = ls_charc_val_api-value_to
             unit_from      = ls_charc_val_api-unit_from
             unit_to        = ls_charc_val_api-unit_to
             value_relation = ls_charc_val_api-value_relation ] ) ) OR
         ( <ls_charc_create_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-curr AND
           line_exists( <ls_charc_create_data>-charcval[
             value_from     = ls_charc_val_api-value_from
             value_to       = ls_charc_val_api-value_to
             currency_from  = ls_charc_val_api-currency_from
             currency_to    = ls_charc_val_api-currency_to
             value_relation = ls_charc_val_api-value_relation ] ) ) OR
         ( ( <ls_charc_create_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-date OR
             <ls_charc_create_data>-charc-data_type = if_ngc_c=>gc_charcdatatype-time ) AND
           line_exists( <ls_charc_create_data>-charcval[
             value_from     = ls_charc_val_api-value_from
             value_to       = ls_charc_val_api-value_to
             value_relation = ls_charc_val_api-value_relation ] ) ).
          " Characteristic value already exists
          MESSAGE e020(ngc_rap) INTO lv_message.
          me->add_charc_val_message(
            EXPORTING
              iv_root_charcinternalid = <ls_charc_val>-charcinternalid
              iv_charcinternalid      = <ls_charc_val>-charcinternalid
              iv_position_number      = <ls_charc_val>-charcvaluepositionnumber
              iv_cid                  = <ls_charc_val>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        IF line_exists( <ls_charc_create_data>-charcval[
            value_char     = ls_charc_val_api-value_char
            currency_from  = ls_charc_val_api-currency_from
            currency_to    = ls_charc_val_api-currency_to
            unit_from      = ls_charc_val_api-unit_from
            unit_to        = ls_charc_val_api-unit_to
            value_from     = ls_charc_val_api-value_from
            value_to       = ls_charc_val_api-value_to
            value_relation = ls_charc_val_api-value_relation ] ).
          " Characteristic value already exists
          MESSAGE e020(ngc_rap) INTO lv_message.
          me->add_charc_val_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val>-charcinternalid
              iv_position_number      = <ls_charc_val>-charcvaluepositionnumber
              iv_cid                  = <ls_charc_val>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).

          CONTINUE.
        ENDIF.

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid                     = <ls_charc_val>-%cid.
        <ls_mapped>-charcinternalid          = <ls_charc_create_data>-charc-charcinternalid.
        <ls_mapped>-charcvaluepositionnumber = lv_positionnumber_tmp.

        " Execute checks
        DATA(ls_charc_create_data) = <ls_charc_create_data>.
        APPEND INITIAL LINE TO ls_charc_create_data-charcval ASSIGNING FIELD-SYMBOL(<ls_charc_val_create>).
        <ls_charc_val_create>                          = ls_charc_val_api.
        <ls_charc_val_create>-charcvaluepositionnumber = lv_positionnumber_tmp.
        <ls_charc_val_create>-cid                      = <ls_charc_val>-%cid.
        <ls_charc_val_create>-created                  = abap_true.

        DATA(lt_return) = me->modify_charc_data(
          is_charc_data  = ls_charc_create_data
          iv_deep_insert = boolc( lv_root_idx IS NOT INITIAL ) ).

        CALL FUNCTION 'CTMV_CHARACT_INIT'.

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_val_message(
            EXPORTING
              iv_root_charcinternalid = <ls_create>-charcinternalid
              iv_charcinternalid      = <ls_charc_val>-charcinternalid
              iv_position_number      = <ls_charc_val>-charcvaluepositionnumber
              iv_cid                  = <ls_charc_val>-%cid
              iv_set_failed           = abap_true
              iv_new                  = lv_new
              is_bapiret              = <ls_return>
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          <ls_charc_create_data> = ls_charc_create_data.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.