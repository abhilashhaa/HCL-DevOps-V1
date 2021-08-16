  METHOD if_ngc_bil_chr~delete_charc_desc.

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
        me->add_charc_desc_message(
          EXPORTING
            iv_root_charcinternalid = <ls_delete>-charcinternalid
            iv_charcinternalid      = <ls_delete>-charcinternalid
            iv_language             = <ls_delete>-language
            iv_cid                  = <ls_delete>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).

        CONTINUE.
      ENDIF.

      IF lines( <ls_change_data>-charcdesc ) = 1.
        " You cannot delete the default characteristic description
        MESSAGE e031(ngc_rap) INTO lv_message.
        me->add_charc_desc_message(
          EXPORTING
            iv_root_charcinternalid = <ls_delete>-charcinternalid
            iv_charcinternalid      = <ls_delete>-charcinternalid
            iv_language             = <ls_delete>-language
            iv_cid                  = <ls_delete>-%cid_ref
            iv_set_failed           = abap_true
            iv_new                  = lv_new
          CHANGING
            ct_reported             = et_reported
            ct_failed               = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_charc_desc) = VALUE #( <ls_change_data>-charcdesc[ language_int = <ls_delete>-language ] OPTIONAL ).

      IF ls_charc_desc IS INITIAL.
        IF lv_new = abap_true.
          DELETE mt_charc_change_data
            WHERE
              charc-charcinternalid = <ls_delete>-charcinternalid.
        ENDIF.

        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid = <ls_delete>-charcinternalid.
        <ls_failed>-language        = <ls_delete>-language.
        <ls_failed>-%cid            = <ls_delete>-%cid_ref.
      ELSE.
        " Execute checks
        DATA(ls_change_data) = <ls_change_data>.

        DELETE ls_change_data-charcdesc
          WHERE
            language_int = <ls_delete>-language.

        DATA(lt_return) = me->modify_charc_data( ls_change_data ).

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_charc_desc_message(
            EXPORTING
              iv_root_charcinternalid = <ls_delete>-charcinternalid
              iv_charcinternalid      = <ls_delete>-charcinternalid
              iv_language             = <ls_delete>-language
              iv_cid                  = <ls_delete>-%cid_ref
              iv_set_failed           = abap_true
              iv_new                  = lv_new
              is_bapiret              = <ls_return>
            CHANGING
              ct_reported             = et_reported
              ct_failed               = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          DELETE <ls_change_data>-charcdesc
            WHERE
              language_int = <ls_delete>-language.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.