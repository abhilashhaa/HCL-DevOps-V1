  METHOD if_ngc_bil_cls~update_class_text.

    FIELD-SYMBOLS:
      <ls_class_change> TYPE lty_s_class_change,
      <ls_class_text>   TYPE bapi1003_longtext.

    CLEAR: et_failed, et_reported.

    LOOP AT it_update ASSIGNING FIELD-SYMBOL(<ls_update>).
      UNASSIGN: <ls_class_change>, <ls_class_text>.

      me->load_class_data( <ls_update>-classinternalid ).
      ASSIGN mt_class_change[ classinternalid = <ls_update>-classinternalid ] TO <ls_class_change>.

      IF <ls_class_change> IS NOT ASSIGNED.
        " Class does not exist
        MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
        me->add_classtext_message(
          EXPORTING
            iv_classinternalid = <ls_update>-classinternalid
            iv_language        = <ls_update>-language
            iv_longtextid      = <ls_update>-longtextid
            iv_cid             = <ls_update>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_class_change) = <ls_class_change>.

      ASSIGN ls_class_change-t_classtext_new[ langu = <ls_update>-language text_type = <ls_update>-longtextid+2 ] TO <ls_class_text>.

      IF <ls_class_text> IS NOT ASSIGNED.
        " Keyword is not assigned to class &1 of class type &2
        MESSAGE e043(ngc_rap) WITH ls_class_change-class ls_class_change-classtype INTO lv_dummy ##NEEDED.
        me->add_classtext_message(
          EXPORTING
            iv_classinternalid = <ls_update>-classinternalid
            iv_language        = <ls_update>-language
            iv_longtextid      = <ls_update>-longtextid
            iv_cid             = <ls_update>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

          DELETE mt_class_change
            WHERE
              classinternalid = <ls_update>-classinternalid.

        CONTINUE.
      ENDIF.

      <ls_class_text> = me->map_classtext_vdm_api(
        is_classtext_vdm_upd = <ls_update>
        is_classtext_api     = <ls_class_text> ).

      DATA(lt_return) = me->modify_class_data(
        is_class_data   = ls_class_change
        iv_clear_buffer = abap_true ).

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_classtext_message(
          EXPORTING
            iv_classinternalid = <ls_update>-classinternalid
            iv_language        = <ls_update>-language
            iv_longtextid      = <ls_update>-longtextid
            iv_cid             = <ls_update>-%cid_ref
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_class_change> = ls_class_change.

        APPEND gc_operation_type-update_text TO <ls_class_change>-t_operation_log.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.