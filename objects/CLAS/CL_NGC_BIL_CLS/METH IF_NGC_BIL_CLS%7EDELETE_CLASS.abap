  METHOD if_ngc_bil_cls~delete_class.

    CLEAR: et_failed, et_reported.


    LOOP AT it_delete ASSIGNING FIELD-SYMBOL(<ls_delete>).
      DATA(ls_class) = me->single_class_by_int_id( <ls_delete>-classinternalid ).

      IF ls_class IS INITIAL.
        " Class does not exist
        MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
        me->add_class_message(
          EXPORTING
            iv_classinternalid = <ls_delete>-classinternalid
            iv_cid             = <ls_delete>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(lt_return) = mo_ngc_db_access->delete_class_api(
          iv_classtype = ls_class-classtype
          iv_class     = ls_class-class ).
      mo_ngc_db_access->clear_bapi_buffer( ).

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_class_message(
          EXPORTING
            iv_classinternalid = <ls_delete>-classinternalid
            iv_cid             = <ls_delete>-%cid_ref
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        APPEND <ls_delete> TO mt_class_delete.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.