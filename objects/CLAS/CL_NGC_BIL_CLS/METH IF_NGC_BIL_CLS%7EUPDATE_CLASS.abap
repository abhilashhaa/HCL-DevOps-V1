  METHOD if_ngc_bil_cls~update_class.

    FIELD-SYMBOLS:
      <ls_class_change> TYPE lty_s_class_change.

    CLEAR: et_failed, et_reported.

    LOOP AT it_update ASSIGNING FIELD-SYMBOL(<ls_update>).
      UNASSIGN <ls_class_change>.

      me->load_class_data( <ls_update>-classinternalid ).
      ASSIGN mt_class_change[ classinternalid = <ls_update>-classinternalid ] TO <ls_class_change>.

      IF <ls_class_change> IS NOT ASSIGNED.
        " Class does not exist
        MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
        me->add_class_message(
          EXPORTING
            iv_classinternalid = <ls_update>-classinternalid
            iv_cid             = <ls_update>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_class_change) = <ls_class_change>.

      ls_class_change-s_classbasic_new = me->map_classbasic_vdm_api(
        EXPORTING
          is_class_vdm_upd      = <ls_update>
          is_classbasic_new_api = ls_class_change-s_classbasic_new ).

      DATA(lt_return) = me->modify_class_data(
        is_class_data   = ls_class_change
        iv_clear_buffer = abap_true ).

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
      WHERE type CA gc_error_types.
        me->add_class_message(
            EXPORTING
              iv_classinternalid = <ls_update>-classinternalid
              iv_cid             = <ls_update>-%cid_ref
              is_bapiret         = <ls_return>
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_class_change> = ls_class_change.

        APPEND gc_operation_type-update_class TO <ls_class_change>-t_operation_log.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.