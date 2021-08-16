  METHOD if_ngc_bil_cls~create_class.

    DATA:
      lv_classinternalid_tmp TYPE clint VALUE IS INITIAL.

    CLEAR: et_mapped, et_reported, et_failed.

    LOOP AT it_create ASSIGNING FIELD-SYMBOL(<ls_create>).
      IF <ls_create>-class     IS INITIAL OR
         <ls_create>-classtype IS INITIAL.
        " Class and class type are required
        MESSAGE e014(ngc_rap) INTO DATA(lv_dummy) ##NEEDED.
        me->add_class_message(
          EXPORTING
            iv_classinternalid = <ls_create>-classinternalid
            iv_cid             = <ls_create>-%cid
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      DATA(ls_class) = me->single_class_by_ext_id(
        iv_class     = <ls_create>-class
        iv_classtype = <ls_create>-classtype ).

      IF ls_class IS NOT INITIAL OR line_exists( mt_class_create[ class = <ls_create>-class classtype = <ls_create>-classtype ] ).
        " Class &1 of class type &2 already created
        MESSAGE e001(ngc_rap) WITH <ls_create>-class <ls_create>-classtype INTO lv_dummy ##NEEDED.
        me->add_class_message(
          EXPORTING
            iv_classinternalid = <ls_create>-classinternalid
            iv_cid             = <ls_create>-%cid
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).

        CONTINUE.
      ENDIF.

      " Do mapping and add to buffer
      lv_classinternalid_tmp = lv_classinternalid_tmp + 1.

      " Do VDM to API mapping
      DATA(ls_class_api) = me->map_classbasic_vdm_api(
        EXPORTING
          is_class_vdm      = CORRESPONDING i_clfnclassforkeydatetp( <ls_create> ) ).

      " Do key mappings
      APPEND INITIAL LINE TO et_mapped ASSIGNING FIELD-SYMBOL(<ls_mapped>).
      <ls_mapped>-%cid            = <ls_create>-%cid.
      <ls_mapped>-classinternalid = lv_classinternalid_tmp.

      DATA(lt_return) = mo_ngc_db_access->create_class_api(
        EXPORTING
          iv_class        = <ls_create>-class
          iv_classtype    = <ls_create>-classtype
          is_classbasic   = ls_class_api
          it_classkeyword = VALUE #( ( langu = sy-langu catchword = 'Dummy description' ) ) ) ##NO_TEXT.
      mo_ngc_db_access->clear_bapi_buffer( ).

      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>)
        WHERE
          type CA gc_error_types.
        me->add_class_message(
          EXPORTING
            iv_classinternalid = <ls_create>-classinternalid
            iv_cid             = <ls_create>-%cid
            is_bapiret         = <ls_return>
          CHANGING
            ct_reported        = et_reported
            ct_failed          = et_failed ).
      ENDLOOP.

      IF sy-subrc <> 0.
        " Add characteristic to create to buffer
        APPEND INITIAL LINE TO mt_class_create ASSIGNING FIELD-SYMBOL(<ls_class_create>).
        <ls_class_create>-s_classbasic_new = ls_class_api.
        <ls_class_create>-classinternalid  = lv_classinternalid_tmp.
        <ls_class_create>-classtype        = <ls_create>-classtype.
        <ls_class_create>-class            = <ls_create>-class.
        <ls_class_create>-cid              = <ls_create>-%cid.

        APPEND gc_operation_type-create_class TO <ls_class_create>-t_operation_log.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.