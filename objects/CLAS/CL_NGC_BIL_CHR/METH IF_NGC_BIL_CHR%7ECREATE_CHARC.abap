  METHOD if_ngc_bil_chr~create_charc.

    DATA:
      lv_charcinternalid_tmp TYPE atinn VALUE IS INITIAL.


    CLEAR: et_failed, et_mapped, et_reported.


    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).

*--------------------------------------------------------------------*
* Check if name is provided
*--------------------------------------------------------------------*

      IF <ls_create>-characteristic IS INITIAL.
        " Define a characteristic name
        MESSAGE e004(ngc_rap) INTO DATA(lv_message).
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_create>-charcinternalid
            iv_cid             = <ls_create>-%cid
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*
* Check if status is provided
*--------------------------------------------------------------------*

      IF <ls_create>-charcstatus IS INITIAL.
        " Define a status for characteristic &1
        MESSAGE e015(ngc_rap) WITH <ls_create>-characteristic INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_create>-charcinternalid
            iv_cid             = <ls_create>-%cid
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*
* Check if datatype is valid
*--------------------------------------------------------------------*

      IF <ls_create>-charcdatatype <> if_ngc_c=>gc_charcdatatype-char AND
         <ls_create>-charcdatatype <> if_ngc_c=>gc_charcdatatype-curr AND
         <ls_create>-charcdatatype <> if_ngc_c=>gc_charcdatatype-date AND
         <ls_create>-charcdatatype <> if_ngc_c=>gc_charcdatatype-num AND
         <ls_create>-charcdatatype <> if_ngc_c=>gc_charcdatatype-time.
        " Data type &1 does not exist
        MESSAGE e010(ngc_rap) WITH <ls_create>-charcdatatype INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_create>-charcinternalid
            iv_cid             = <ls_create>-%cid
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*
* Check length is not initial
*--------------------------------------------------------------------*

      IF <ls_create>-charclength IS INITIAL.
        " Characteristic length should be defined
        MESSAGE e040(ngc_rap) INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_create>-charcinternalid
            iv_cid             = <ls_create>-%cid
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*
* Check change number
*--------------------------------------------------------------------*

      IF <ls_create>-changenumber IS NOT INITIAL.
        " Using a change number is not supported
        MESSAGE e047(ngc_rap) INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_create>-charcinternalid
            iv_cid             = <ls_create>-%cid
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*
* Check if same name already exists
*--------------------------------------------------------------------*

      DATA(lv_exists_in_db) = me->check_charc_exists_by_name( iv_characteristic = <ls_create>-characteristic ).

      IF lv_exists_in_db = abap_true OR line_exists( mt_charc_create_data[ charc-charact_name = <ls_create>-characteristic ] ).
        " Characteristic &1 already exists
        MESSAGE e019(ngc_rap) WITH <ls_create>-characteristic INTO lv_message.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_create>-charcinternalid
            iv_cid             = <ls_create>-%cid
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*
* Do mapping and add to buffer
*--------------------------------------------------------------------*

      lv_charcinternalid_tmp = lv_charcinternalid_tmp + 1.

      " Do VDM to API mapping
      DATA(ls_charc_vdm) = VALUE i_clfncharcforkeydatetp( ).
      ls_charc_vdm = CORRESPONDING #( <ls_create> ).
      DATA(ls_charc_api) = me->map_charc_vdm_api(
        is_charc_vdm = ls_charc_vdm ).

      " Do key mappings
      APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
      <ls_mapped>-%cid            = <ls_create>-%cid.
      <ls_mapped>-charcinternalid = lv_charcinternalid_tmp.

      " Execute checks
      DATA(lt_return) = mo_ngc_db_access->create_characteristic(
        is_characteristic_bapi = ls_charc_api
*       iv_changenumber        = <ls_create>-changenumber
        iv_testrun             = abap_true ).

      CALL FUNCTION 'CTMV_CHARACT_INIT'.

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_create>-charcinternalid
            iv_cid             = <ls_create>-%cid
            iv_set_failed      = abap_true
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        " Add characteristic to create to buffer
        APPEND INITIAL LINE TO mt_charc_create_data ASSIGNING FIELD-SYMBOL(<ls_charc_create_data>).
*       <ls_charc_create_data>-changenumber = <ls_create>-changenumber.
        <ls_charc_create_data>-charc = CORRESPONDING #( ls_charc_api ).
        <ls_charc_create_data>-charc-charcinternalid = lv_charcinternalid_tmp.
        <ls_charc_create_data>-charc-cid             = <ls_create>-%cid.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.