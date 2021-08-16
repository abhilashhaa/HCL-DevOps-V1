  METHOD if_ngc_bil_chr~delete_charc_val.

    FIELD-SYMBOLS:
      <ls_change_data> TYPE lty_s_charc_data.


    CLEAR: et_failed, et_reported.


    LOOP AT it_delete ASSIGNING FIELD-SYMBOL(<ls_delete>).
      UNASSIGN <ls_change_data>.

      DATA(lv_new) = me->load_charc_data( <ls_delete>-charcinternalid ).
      ASSIGN mt_charc_change_data[ charc-charcinternalid = <ls_delete>-charcinternalid ] TO <ls_change_data>.

      IF <ls_change_data> IS NOT ASSIGNED.
        " Characteristic does not exist
        MESSAGE e026(ngc_rap) INTO DATA(lv_message).
        me->add_charc_val_message(
          EXPORTING
            iv_charcinternalid = <ls_delete>-charcinternalid
            iv_position_number = <ls_delete>-charcvaluepositionnumber
            iv_cid             = <ls_delete>-%cid_ref
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_charc_val) = VALUE #( <ls_change_data>-charcval[ charcvaluepositionnumber = <ls_delete>-charcvaluepositionnumber ] OPTIONAL ).

      IF ls_charc_val IS INITIAL.
        IF lv_new = abap_true.
          DELETE mt_charc_change_data
            WHERE
              charc-charcinternalid = <ls_delete>-charcinternalid.
        ENDIF.

        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid          = <ls_delete>-charcinternalid.
        <ls_failed>-charcvaluepositionnumber = <ls_delete>-charcvaluepositionnumber.
        <ls_failed>-%cid                     = <ls_delete>-%cid_ref.
      ELSE.
        " Execute checks
        DATA(ls_change_data) = <ls_change_data>.
        DELETE ls_change_data-charcval
          WHERE
            charcvaluepositionnumber = <ls_delete>-charcvaluepositionnumber.

        DATA(lt_return) = me->modify_charc_data( ls_change_data ).

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_val_message(
            EXPORTING
              iv_root_charcinternalid = <ls_delete>-charcinternalid
              iv_charcinternalid      = <ls_delete>-charcinternalid
              iv_position_number      = <ls_delete>-charcvaluepositionnumber
              iv_cid                  = <ls_delete>-%cid_ref
              iv_set_failed           = abap_true
              iv_new                  = lv_new
              is_bapiret              = <ls_return>
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          DELETE <ls_change_data>-charcval
            WHERE
              charcvaluepositionnumber = <ls_delete>-charcvaluepositionnumber.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.