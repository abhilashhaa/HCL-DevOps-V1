  METHOD if_ngc_bil_cls_transactional~adjust_numbers.

    DATA: lt_class_text_del TYPE tt_bapi1003_longtext.

    CLEAR: et_class_mapped, et_class_desc_mapped, et_class_keyword_mapped,
           et_class_text_mapped, et_class_charc_mapped.

    " Ensure empty buffer
    mo_ngc_db_access->clear_bapi_buffer( ).

    LOOP AT mt_class_create ASSIGNING FIELD-SYMBOL(<ls_class_create>).
      CHECK <ls_class_create>-t_operation_log IS NOT INITIAL.

      INSERT LINES OF <ls_class_create>-t_classdesc INTO <ls_class_create>-t_classkeyword INDEX 1.

      me->modify_class_data(
        is_class_data  = <ls_class_create>
        iv_deep_insert = abap_true ).

      DATA(lv_classinternalid_db) = me->mo_ngc_db_access->get_classintid_from_buffer(
        iv_class     = <ls_class_create>-class
        iv_classtype = <ls_class_create>-classtype ).

      APPEND INITIAL LINE TO et_class_mapped ASSIGNING FIELD-SYMBOL(<ls_class_mapped>).
      <ls_class_mapped>-%tmp-classinternalid = <ls_class_create>-classinternalid.
      <ls_class_mapped>-classinternalid      = lv_classinternalid_db.

      LOOP AT <ls_class_create>-t_classdesc_new ASSIGNING FIELD-SYMBOL(<ls_class_desc_create>).
        APPEND INITIAL LINE TO et_class_desc_mapped ASSIGNING FIELD-SYMBOL(<ls_class_desc_mapped>).
        <ls_class_desc_mapped>-%tmp-classinternalid = <ls_class_create>-classinternalid.
        <ls_class_desc_mapped>-%tmp-language        = <ls_class_desc_create>-langu.
        <ls_class_desc_mapped>-classinternalid      = lv_classinternalid_db.
        <ls_class_desc_mapped>-language             = <ls_class_desc_create>-langu.
      ENDLOOP.

      LOOP AT <ls_class_create>-t_classkeyword_new ASSIGNING FIELD-SYMBOL(<ls_class_keyword_create>).
        DATA(ls_classkeyword_db) = me->mo_ngc_db_access->get_classkeyword_from_buffer(
          VALUE #(
            classinternalid  = lv_classinternalid_db
            language         = <ls_class_keyword_create>-langu
            classkeywordtext = <ls_class_keyword_create>-catchword ) ).

        APPEND INITIAL LINE TO et_class_keyword_mapped ASSIGNING FIELD-SYMBOL(<ls_class_keyword_mapped>).
        <ls_class_keyword_mapped>-%tmp-classinternalid            = <ls_class_create>-classinternalid.
        <ls_class_keyword_mapped>-%tmp-language                   = <ls_class_keyword_create>-langu.
        <ls_class_keyword_mapped>-%tmp-classkeywordpositionnumber = <ls_class_keyword_create>-classkeywordpositionnumber.
        <ls_class_keyword_mapped>-classinternalid                 = lv_classinternalid_db.
        <ls_class_keyword_mapped>-language                        = <ls_class_keyword_create>-langu.
        <ls_class_keyword_mapped>-classkeywordpositionnumber      = ls_classkeyword_db-classkeywordpositionnumber.
      ENDLOOP.

      LOOP AT <ls_class_create>-t_classtext_new ASSIGNING FIELD-SYMBOL(<ls_class_text_create>).
        APPEND INITIAL LINE TO et_class_text_mapped ASSIGNING FIELD-SYMBOL(<ls_class_text_mapped>).
        <ls_class_text_mapped>-%tmp-classinternalid = <ls_class_create>-classinternalid.
        <ls_class_text_mapped>-%tmp-language        = <ls_class_text_create>-langu.
        <ls_class_text_mapped>-%tmp-longtextid      = |00{ <ls_class_text_create>-text_type }|.
        <ls_class_text_mapped>-classinternalid      = lv_classinternalid_db.
        <ls_class_text_mapped>-language             = <ls_class_text_create>-langu.
        <ls_class_text_mapped>-longtextid           = |00{ <ls_class_text_create>-text_type }|.
      ENDLOOP.

      LOOP AT <ls_class_create>-t_classcharc_new ASSIGNING FIELD-SYMBOL(<ls_class_charc_create>).
        APPEND INITIAL LINE TO et_class_charc_mapped ASSIGNING FIELD-SYMBOL(<ls_class_charc_mapped>).
        <ls_class_charc_mapped>-%tmp-classinternalid = <ls_class_create>-classinternalid.
        <ls_class_charc_mapped>-%tmp-charcinternalid = <ls_class_charc_create>-charcinternalid.
        <ls_class_charc_mapped>-classinternalid      = lv_classinternalid_db.
        <ls_class_charc_mapped>-charcinternalid      = <ls_class_charc_create>-charcinternalid.
      ENDLOOP.
    ENDLOOP.

    LOOP AT mt_class_change ASSIGNING FIELD-SYMBOL(<ls_class_change>).
      CLEAR: lt_class_text_del.

      CHECK <ls_class_change>-t_operation_log IS NOT INITIAL.

      LOOP AT <ls_class_change>-t_classtext_new ASSIGNING FIELD-SYMBOL(<ls_class_text_new>)
        WHERE
          fldelete = abap_true.
        APPEND <ls_class_text_new> TO lt_class_text_del.
      ENDLOOP.

      IF lt_class_text_del IS INITIAL.
        me->modify_class_data( <ls_class_change> ).

        LOOP AT <ls_class_change>-t_classkeyword_new ASSIGNING FIELD-SYMBOL(<ls_class_keyword_change>)
          WHERE created = abap_true.
          ls_classkeyword_db = me->mo_ngc_db_access->get_classkeyword_from_buffer(
            VALUE #(
              classinternalid  = <ls_class_change>-classinternalid
              language         = <ls_class_keyword_change>-langu
              classkeywordtext = <ls_class_keyword_change>-catchword ) ).

          APPEND INITIAL LINE TO et_class_keyword_mapped ASSIGNING <ls_class_keyword_mapped>.
          <ls_class_keyword_mapped>-%tmp-classinternalid            = <ls_class_change>-classinternalid.
          <ls_class_keyword_mapped>-%tmp-language                   = <ls_class_keyword_change>-langu.
          <ls_class_keyword_mapped>-%tmp-classkeywordpositionnumber = <ls_class_keyword_change>-classkeywordpositionnumber.
          <ls_class_keyword_mapped>-classinternalid                 = <ls_class_change>-classinternalid.
          <ls_class_keyword_mapped>-language                        = <ls_class_keyword_change>-langu.
          <ls_class_keyword_mapped>-classkeywordpositionnumber      = ls_classkeyword_db-classkeywordpositionnumber.
        ENDLOOP.
      ELSE.
        mo_ngc_db_access->delete_classtext_api(
          iv_class     = <ls_class_change>-class
          iv_classtype = <ls_class_change>-classtype
          it_classtext = lt_class_text_del ).
      ENDIF.
    ENDLOOP.

    LOOP AT mt_class_delete ASSIGNING FIELD-SYMBOL(<ls_class_delete>).
      DATA(ls_class) = me->single_class_by_int_id(
        iv_classinternalid = <ls_class_delete>-classinternalid
        iv_keydate         = sy-datum ).

      me->mo_ngc_db_access->delete_class_api(
        iv_class     = ls_class-class
        iv_classtype = ls_class-classtype ).
    ENDLOOP.

  ENDMETHOD.