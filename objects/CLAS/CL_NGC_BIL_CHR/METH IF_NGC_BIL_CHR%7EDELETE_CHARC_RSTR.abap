  METHOD if_ngc_bil_chr~delete_charc_rstr.

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
        me->add_charc_rstr_message(
          EXPORTING
            iv_charcinternalid = <ls_delete>-charcinternalid
            iv_classtype       = <ls_delete>-classtype
            iv_cid             = <ls_delete>-%cid_ref
            iv_set_failed      = abap_true
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_charc_rstr) = VALUE #( <ls_change_data>-charcrstr[ class_type = <ls_delete>-classtype ] OPTIONAL ).

      IF ls_charc_rstr IS INITIAL.
        IF lv_new = abap_true.
          DELETE mt_charc_change_data
            WHERE
              charc-charcinternalid = <ls_delete>-charcinternalid.
        ENDIF.
      ELSE.
        " Execute checks
        DATA(ls_change_data) = <ls_change_data>.
        DELETE ls_change_data-charcrstr
          WHERE
            class_type = <ls_delete>-classtype.

        DATA(lt_return) = me->modify_charc_data( ls_change_data ).

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_rstr_message(
            EXPORTING
              iv_root_charcinternalid = <ls_delete>-charcinternalid
              iv_charcinternalid      = <ls_delete>-charcinternalid
              iv_classtype            = <ls_delete>-classtype
              iv_cid                  = <ls_delete>-%cid_ref
              iv_set_failed           = abap_true
              iv_new                  = lv_new
              is_bapiret              = <ls_return>
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          DELETE <ls_change_data>-charcrstr
            WHERE
              class_type = <ls_delete>-classtype.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.