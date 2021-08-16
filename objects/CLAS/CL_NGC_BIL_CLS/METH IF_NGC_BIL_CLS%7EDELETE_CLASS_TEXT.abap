  METHOD if_ngc_bil_cls~delete_class_text.

    FIELD-SYMBOLS:
      <ls_class_change>   TYPE lty_s_class_change,
      <ls_class_text_new> TYPE bapi1003_longtext.

    CLEAR: et_failed, et_reported.

    LOOP AT it_delete ASSIGNING FIELD-SYMBOL(<ls_delete>).
      UNASSIGN: <ls_class_change>, <ls_class_text_new>.

      me->load_class_data( <ls_delete>-classinternalid ).
      ASSIGN mt_class_change[ classinternalid = <ls_delete>-classinternalid ] TO <ls_class_change>.

      IF <ls_class_change> IS NOT ASSIGNED.
        " Class does not exist
        MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
        me->add_classtext_message(
          EXPORTING
            iv_classinternalid = <ls_delete>-classinternalid
            iv_longtextid      = <ls_delete>-longtextid
            iv_language        = <ls_delete>-language
            iv_cid             = <ls_delete>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_class_change) = <ls_class_change>.

      ASSIGN ls_class_change-t_classtext_new[ langu = <ls_delete>-language text_type = <ls_delete>-longtextid+2 ]
        TO <ls_class_text_new>.

      IF <ls_class_text_new> IS NOT ASSIGNED.
        " Class text does not exist
        MESSAGE e041(ngc_rap) INTO lv_dummy ##NEEDED.
        me->add_classtext_message(
          EXPORTING
            iv_classinternalid = <ls_delete>-classinternalid
            iv_language        = <ls_delete>-language
            iv_longtextid      = <ls_delete>-longtextid
            iv_cid             = <ls_delete>-%cid_ref
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

          DELETE mt_class_change
            WHERE
              classinternalid = <ls_delete>-classinternalid.

        CONTINUE.
      ENDIF.

      <ls_class_text_new>-fldelete = abap_true.

      DATA(lt_return) =  mo_ngc_db_access->delete_classtext_api(
        iv_class     = <ls_class_change>-class
        iv_classtype = <ls_class_change>-classtype
        it_classtext = VALUE #( ( <ls_class_text_new> ) ) ).
      " Clearing the buffer leads to incorrect behavior

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_classtext_message(
          EXPORTING
            iv_classinternalid = <ls_delete>-classinternalid
            iv_language        = <ls_delete>-language
            iv_longtextid      = <ls_delete>-longtextid
            iv_cid             = <ls_delete>-%cid_ref
            iv_set_failed      = abap_true
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_class_change> = ls_class_change.

        APPEND gc_operation_type-delete_text TO <ls_class_change>-t_operation_log.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.