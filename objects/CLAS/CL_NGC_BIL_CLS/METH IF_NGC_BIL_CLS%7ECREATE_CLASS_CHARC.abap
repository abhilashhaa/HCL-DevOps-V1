  METHOD if_ngc_bil_cls~create_class_charc.

    FIELD-SYMBOLS:
      <ls_class_change> TYPE lty_s_class_change.

    CLEAR: et_failed, et_mapped, et_reported.

    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      UNASSIGN <ls_class_change>.

      DATA(lv_ancestor_idx) = me->get_ancestor_idx( <ls_create>-%cid_ref ).

      IF lv_ancestor_idx IS INITIAL.
        me->load_class_data( <ls_create>-classinternalid ).
        ASSIGN mt_class_change[ classinternalid = <ls_create>-classinternalid ] TO <ls_class_change>.
      ELSE.
        ASSIGN mt_class_create[ lv_ancestor_idx ] TO <ls_class_change>.
      ENDIF.

      LOOP AT <ls_create>-%target ASSIGNING FIELD-SYMBOL(<ls_class_charc>).
        IF <ls_class_change> IS NOT ASSIGNED.
          " Class does not exist
          MESSAGE e002(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
          me->add_classcharc_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_charcinternalid = <ls_class_charc>-charcinternalid
              iv_cid             = <ls_class_charc>-%cid
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).

          CONTINUE.
        ENDIF.

        " Do VDM to API mapping
        DATA(ls_class_charc_api) = me->map_classcharc_vdm_api(
              is_classcharc_vdm = CORRESPONDING i_clfnclasscharcforkeydatetp( <ls_class_charc> ) ).

        IF me->get_characteristic( ls_class_charc_api-charcinternalid ) IS INITIAL.
          " Characteristic does not exist
          MESSAGE e026(ngc_rap) INTO lv_dummy ##NEEDED.
          me->add_classcharc_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_charcinternalid = <ls_class_charc>-charcinternalid
              iv_cid             = <ls_class_charc>-%cid
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).

          CONTINUE.
        ENDIF.

        IF me->is_charc_resticted( iv_charcinternalid = ls_class_charc_api-charcinternalid iv_classtype = <ls_class_change>-classtype ).
          " Characteristic &1 cannot be used with class type &2
          MESSAGE e018(ngc_rap) WITH ls_class_charc_api-name_char <ls_class_change>-classtype
            INTO lv_dummy ##NEEDED.
          me->add_classcharc_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_charcinternalid = <ls_class_charc>-charcinternalid
              iv_cid             = <ls_class_charc>-%cid
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).

          CONTINUE.
        ENDIF.

        IF line_exists( <ls_class_change>-t_classcharc_new[ charcinternalid = ls_class_charc_api-charcinternalid ] ).
          " Characteristic is already assigned to class of class type
          MESSAGE e044(ngc_rap) WITH ls_class_charc_api-name_char <ls_class_change>-class <ls_class_change>-classtype INTO lv_dummy ##NEEDED.
          me->add_classcharc_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_charcinternalid = <ls_class_charc>-charcinternalid
              iv_cid             = <ls_class_charc>-%cid
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).
            DELETE mt_class_change WHERE classinternalid = <ls_class_change>-classinternalid.
          CONTINUE.
        ENDIF.

        " Do key mapping
        APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
        <ls_mapped>-%cid            = <ls_class_charc>-%cid.
        <ls_mapped>-classinternalid = <ls_create>-classinternalid.
        <ls_mapped>-charcinternalid = ls_class_charc_api-charcinternalid.

        " Execute checks
        DATA(ls_class_change) = <ls_class_change>.

        APPEND INITIAL LINE TO ls_class_change-t_classcharc_new ASSIGNING FIELD-SYMBOL(<ls_class_charc_new>).
        <ls_class_charc_new>                 = CORRESPONDING #( ls_class_charc_api ).
        <ls_class_charc_new>-charcinternalid = ls_class_charc_api-charcinternalid.

        DATA(lt_return) = me->modify_class_data(
          is_class_data   = ls_class_change
          iv_deep_insert  = boolc( lv_ancestor_idx IS NOT INITIAL )
          iv_clear_buffer = abap_true ).

        LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
          WHERE
            type CA gc_error_types.
          me->add_classcharc_message(
            EXPORTING
              iv_classinternalid = <ls_create>-classinternalid
              iv_charcinternalid = <ls_class_charc>-charcinternalid
              iv_cid             = <ls_class_charc>-%cid
              is_bapiret         = <ls_return>
            CHANGING
              ct_reported        = et_reported
              ct_failed          = et_failed ).
        ENDLOOP.

        IF sy-subrc <> 0.
          <ls_class_change> = ls_class_change.

          APPEND gc_operation_type-create_charc TO <ls_class_change>-t_operation_log.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.