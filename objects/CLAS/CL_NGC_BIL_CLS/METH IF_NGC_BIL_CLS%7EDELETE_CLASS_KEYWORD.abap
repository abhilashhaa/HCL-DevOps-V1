  METHOD if_ngc_bil_cls~delete_class_keyword.

    FIELD-SYMBOLS:
      <ls_class_change>      TYPE lty_s_class_change,
      <ls_class_keyword_new> TYPE lty_s_class_keyword.

    CLEAR: et_failed, et_reported.

    LOOP AT it_delete ASSIGNING FIELD-SYMBOL(<ls_delete>).
      UNASSIGN: <ls_class_change>, <ls_class_keyword_new>.

      me->load_class_data( <ls_delete>-classinternalid ).
      ASSIGN mt_class_change[ classinternalid = <ls_delete>-classinternalid ] TO <ls_class_change>.

      IF <ls_class_change> IS NOT ASSIGNED.
        " Class does not exist
        MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
        me->add_classkeyword_message(
          EXPORTING
            iv_classinternalid            = <ls_delete>-classinternalid
            iv_classkeywordpositionnumber = <ls_delete>-classkeywordpositionnumber
            iv_language                   = <ls_delete>-language
            iv_cid                        = <ls_delete>-%cid_ref
          CHANGING
            ct_reported                   = et_reported
            ct_failed                     = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_class_change) = <ls_class_change>.

      ASSIGN ls_class_change-t_classkeyword_new[ langu = <ls_delete>-language classkeywordpositionnumber = <ls_delete>-classkeywordpositionnumber ]
        TO <ls_class_keyword_new>.

      IF <ls_class_keyword_new> IS NOT ASSIGNED.
        " Keyword is not assigned to class &1 of class type &2
        MESSAGE e043(ngc_rap) WITH <ls_class_change>-class <ls_class_change>-classtype INTO lv_dummy ##NEEDED.
        me->add_classkeyword_message(
          EXPORTING
            iv_classinternalid            = <ls_delete>-classinternalid
            iv_language                   = <ls_delete>-language
            iv_classkeywordpositionnumber = <ls_delete>-classkeywordpositionnumber
            iv_cid                        = <ls_delete>-%cid_ref
          CHANGING
            ct_reported                   = et_reported
            ct_failed                     = et_failed ).

          DELETE mt_class_change
            WHERE
              classinternalid = <ls_delete>-classinternalid.

        CONTINUE.
      ENDIF.

      <ls_class_keyword_new>-delete_flag = abap_true.

      DATA(lt_return) = me->modify_class_data(
        is_class_data   = ls_class_change
        iv_clear_buffer = abap_true ).

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_classkeyword_message(
          EXPORTING
            iv_classinternalid            = <ls_delete>-classinternalid
            iv_language                   = <ls_delete>-language
            iv_classkeywordpositionnumber = <ls_delete>-classkeywordpositionnumber
            iv_cid                        = <ls_delete>-%cid_ref
            is_bapiret                    = <ls_return>
          CHANGING
            ct_reported                   = et_reported
            ct_failed                     = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        <ls_class_change> = ls_class_change.

        APPEND gc_operation_type-delete_keyword TO <ls_class_change>-t_operation_log.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.