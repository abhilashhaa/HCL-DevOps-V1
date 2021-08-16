  METHOD if_ngc_bil_cls~update_class_desc.

    FIELD-SYMBOLS:
      <ls_class_change> TYPE lty_s_class_change,
      <ls_class_desc>   TYPE bapi1003_catch_new.

    CLEAR: et_failed, et_reported.

    LOOP AT it_update ASSIGNING FIELD-SYMBOL(<ls_update>).
      UNASSIGN: <ls_class_change>, <ls_class_desc>.

      me->load_class_data( <ls_update>-classinternalid ).
      ASSIGN mt_class_change[ classinternalid = <ls_update>-classinternalid ] TO <ls_class_change>.

      IF <ls_class_change> IS NOT ASSIGNED.
        " Class does not exist
        MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
        me->add_classdesc_message(
          EXPORTING
            iv_classinternalid = <ls_update>-classinternalid
            iv_language        = <ls_update>-language
            iv_cid             = <ls_update>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_class_change) = <ls_class_change>.

      ASSIGN ls_class_change-t_classdesc_new[ langu = <ls_update>-language ] TO <ls_class_desc>.

      IF <ls_class_desc> IS NOT ASSIGNED.
        " No description defined in language &1
        MESSAGE e011(ngc_rap) WITH <ls_update>-language INTO lv_dummy ##NEEDED.
        me->add_classdesc_message(
          EXPORTING
            iv_classinternalid = <ls_update>-classinternalid
            iv_language        = <ls_update>-language
            iv_cid             = <ls_update>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

          DELETE mt_class_change
            WHERE
              classinternalid = <ls_update>-classinternalid.

        CONTINUE.
      ENDIF.

      <ls_class_desc> =  me->map_classdesc_vdm_api(
        EXPORTING
          is_classdesc_vdm_upd = <ls_update>
          is_classdesc_new_api = <ls_class_desc> ).

      DATA(lt_return) = me->modify_class_data(
        is_class_data   = ls_class_change
        iv_clear_buffer = abap_true ).

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_classdesc_message(
          EXPORTING
            iv_classinternalid = <ls_update>-classinternalid
            iv_language        = <ls_update>-language
            iv_cid             = <ls_update>-%cid_ref
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_class_change> = ls_class_change.

        APPEND gc_operation_type-update_desc TO <ls_class_change>-t_operation_log.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.