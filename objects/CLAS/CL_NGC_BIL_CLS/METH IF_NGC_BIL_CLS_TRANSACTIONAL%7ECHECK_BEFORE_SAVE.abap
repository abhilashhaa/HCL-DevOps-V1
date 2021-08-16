  METHOD if_ngc_bil_cls_transactional~check_before_save.

    CLEAR: et_class_reported, et_class_failed,
           et_class_desc_reported, et_class_desc_failed,
           et_class_text_reported, et_class_text_failed,
           et_class_keyword_reported, et_class_keyword_failed.


    DATA(lv_not_text_delete) = COND #( WHEN mt_class_delete IS INITIAL THEN abap_false ELSE abap_true ).
    DATA(lv_text_delete) = abap_false.

    LOOP AT mt_class_change ASSIGNING FIELD-SYMBOL(<ls_class_change>).
      IF lv_text_delete <> abap_true AND line_exists( <ls_class_change>-t_operation_log[ table_line = gc_operation_type-delete_text ] ).
        lv_text_delete = abap_true.
      ENDIF.

      IF lv_not_text_delete <> abap_true.
        LOOP AT <ls_class_change>-t_operation_log TRANSPORTING NO FIELDS
          WHERE
            table_line <> gc_operation_type-delete_text.
          EXIT.
        ENDLOOP.

        IF sy-subrc = 0.
          lv_not_text_delete = abap_true.
        ENDIF.
      ENDIF.

      IF lv_text_delete = abap_true AND lv_not_text_delete = abap_true.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_text_delete = abap_true AND lv_not_text_delete = abap_true.
      LOOP AT mt_class_change ASSIGNING <ls_class_change>.
        LOOP AT <ls_class_change>-t_classtext_new ASSIGNING FIELD-SYMBOL(<ls_class_text>)
          WHERE
            fldelete = abap_true.
          <ls_class_text>-fldelete = abap_false.

          " Not allowed to delete text together with other operations
          MESSAGE e049(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
          me->add_classtext_message(
            EXPORTING
              iv_cid             = ''
              iv_classinternalid = <ls_class_change>-classinternalid
              iv_language        = <ls_class_text>-langu
              iv_longtextid      = |00{ <ls_class_text>-text_type }|
            CHANGING
              ct_reported        = et_class_text_reported
              ct_failed          = et_class_text_failed ).
        ENDLOOP.
      ENDLOOP.
    ENDIF.

    " Check if description is defined for all classes
    LOOP AT mt_class_create ASSIGNING FIELD-SYMBOL(<ls_class_create>).
      IF <ls_class_create>-t_classdesc_new IS INITIAL.
        " No description defined for class &1 of class type &2
        MESSAGE e000(ngc_rap) WITH <ls_class_create>-class <ls_class_create>-classtype INTO lv_dummy ##NEEDED.
        me->add_class_message(
          EXPORTING
            iv_classinternalid = <ls_class_create>-classinternalid
            iv_cid             = <ls_class_create>-cid
          CHANGING
            ct_reported        = et_class_reported
            ct_failed          = et_class_failed ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.