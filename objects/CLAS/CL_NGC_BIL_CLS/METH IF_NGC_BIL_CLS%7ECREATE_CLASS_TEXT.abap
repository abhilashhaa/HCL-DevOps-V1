  METHOD if_ngc_bil_cls~create_class_text.

    FIELD-SYMBOLS:
      <ls_class_change> TYPE lty_s_class_change.

    CLEAR: et_failed, et_reported, et_mapped.

    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      UNASSIGN <ls_class_change>.

      DATA(lv_ancestor_idx) = me->get_ancestor_idx( <ls_create>-%cid_ref ).

      IF lv_ancestor_idx IS INITIAL.
        me->load_class_data( <ls_create>-classinternalid ).
        ASSIGN mt_class_change[ classinternalid = <ls_create>-classinternalid ] TO <ls_class_change>.
      ELSE.
        ASSIGN mt_class_create[ lv_ancestor_idx ] TO <ls_class_change>.
      ENDIF.

      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_class_text>).
        IF <ls_class_change> IS NOT ASSIGNED.
          " Class does not exist
          MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
          me->add_classtext_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_language        = <ls_class_text>-language
              iv_longtextid      = <ls_class_text>-longtextid
              iv_cid             = <ls_class_text>-%cid
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).

          CONTINUE.
        ENDIF.

        DATA(lt_classtext_id) = me->classtext_id( <ls_class_change>-classtype ).

        IF NOT line_exists( lt_classtext_id[ txida = <ls_class_text>-longtextid+2 ] ).
          " Class text ID &1 is not assigned to class type &2
          MESSAGE e038(ngc_rap) WITH <ls_class_text>-longtextid <ls_class_change>-classtype INTO lv_dummy ##NEEDED.
          me->add_classtext_message(
            EXPORTING
              iv_longtextid      = <ls_class_text>-longtextid
              iv_language        = <ls_class_text>-language
              iv_classinternalid = <ls_class_change>-classinternalid
              iv_cid             = <ls_class_text>-%cid
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).

          CONTINUE.
        ENDIF.

        " Do VDM to API mapping
        DATA(ls_class_text_api) = me->map_classtext_vdm_api(
          is_classtext_vdm = CORRESPONDING i_clfnclasstextforkeydatetp( <ls_class_text> ) ).

        IF line_exists( <ls_class_change>-t_classtext_new[
             text_type = ls_class_text_api-text_type
             langu     = ls_class_text_api-langu ] ).
          " Class text already created in language &1
          MESSAGE e034(ngc_rap) WITH ls_class_text_api-langu INTO lv_dummy ##NEEDED.
          me->add_classtext_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_language        = <ls_class_text>-language
              iv_longtextid      = <ls_class_text>-longtextid
              iv_cid             = <ls_class_text>-%cid
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).

          CONTINUE.
        ENDIF.

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid            = <ls_class_text>-%cid.
        <ls_mapped>-classinternalid = <ls_create>-classinternalid.
        <ls_mapped>-language        = ls_class_text_api-langu.
        <ls_mapped>-longtextid      = <ls_class_text>-longtextid.

        " Execute checks
        DATA(ls_class_change) = <ls_class_change>.
        APPEND INITIAL LINE TO ls_class_change-t_classtext_new ASSIGNING FIELD-SYMBOL(<ls_class_text_new>).
        <ls_class_text_new> = CORRESPONDING #( ls_class_text_api ).

        DATA(lt_return) = me->modify_class_data(
          is_class_data   = ls_class_change
          iv_deep_insert  = boolc( lv_ancestor_idx IS NOT INITIAL )
          iv_clear_buffer = abap_true ).

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_classtext_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_language        = ls_class_text_api-langu
              iv_longtextid      = <ls_class_text>-longtextid
              iv_cid             = <ls_class_text>-%cid
              is_bapiret         = <ls_return>
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          <ls_class_change> = ls_class_change.

          APPEND gc_operation_type-create_text TO <ls_class_change>-t_operation_log.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.