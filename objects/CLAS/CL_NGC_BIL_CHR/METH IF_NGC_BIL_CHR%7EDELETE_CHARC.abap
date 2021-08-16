  METHOD if_ngc_bil_chr~delete_charc.

    CLEAR: et_failed, et_reported.


    LOOP AT it_delete ASSIGNING FIELD-SYMBOL(<ls_delete>).

*--------------------------------------------------------------------*
* Check if characteristic exists
*--------------------------------------------------------------------*

      DATA(ls_charc) = me->read_characteristic_by_id( <ls_delete>-charcinternalid ).

      IF ls_charc IS INITIAL.
        " Characteristic does not exist
        MESSAGE e026(ngc_rap) INTO DATA(lv_message).
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_delete>-charcinternalid
            iv_cid             = <ls_delete>-%cid_ref
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*
* Execute checks with BAPI
*--------------------------------------------------------------------*

      DATA(lt_return) = mo_ngc_db_access->delete_characteristic(
       iv_characteristic = ls_charc-characteristic
       iv_testrun        = abap_true ).

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_charc_message(
          EXPORTING
            iv_charcinternalid = <ls_delete>-charcinternalid
            iv_cid             = <ls_delete>-%cid_ref
            iv_set_failed      = abap_true
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        IF NOT line_exists( mt_charc_delete_data[ charcinternalid = <ls_delete>-charcinternalid ] ).
          APPEND INITIAL LINE TO mt_charc_delete_data ASSIGNING FIELD-SYMBOL(<ls_charc_delete_data>).
          <ls_charc_delete_data>-charcinternalid = <ls_delete>-charcinternalid.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.