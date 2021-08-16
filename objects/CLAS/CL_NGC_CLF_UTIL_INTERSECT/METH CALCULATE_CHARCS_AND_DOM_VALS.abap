METHOD calculate_charcs_and_dom_vals.

  DATA:
    lo_clf_api_result           TYPE REF TO cl_ngc_clf_api_result,
    lt_collected_char_value     TYPE ngct_core_class_charc_inter,
    lt_collected_char_value_tmp TYPE ngct_core_class_charc_inter,
    ls_collected_char_value     TYPE ngcs_core_class_charc_inter,
    lt_classtypes               TYPE SORTED TABLE OF klassenart WITH UNIQUE DEFAULT KEY,
    lt_charcinternalid          TYPE STANDARD TABLE OF atinn WITH DEFAULT KEY,
    lv_charcdatatype            TYPE atfor,
    ls_core_charc_value         TYPE ngcs_core_charc_value_data,
    lt_core_clf_message         TYPE ngct_core_classification_msg,
    lr_characteristic_key       TYPE REF TO ngcs_clf_characteristic_key.

  FIELD-SYMBOLS:
    <ls_characteristic_key>     TYPE ngcs_clf_characteristic_key.

  CLEAR: eo_clf_api_result.

  IF me->mt_recalc_classtype_range IS INITIAL.
    eo_clf_api_result = lo_clf_api_result.
    RETURN.
  ENDIF.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  LOOP AT it_classes ASSIGNING FIELD-SYMBOL(<ls_class>).
    DATA(ls_class_header) = <ls_class>-class_object->get_header( ).
    IF me->mt_recalc_classtype_range IS NOT INITIAL AND
      ls_class_header-classtype IN me->mt_recalc_classtype_range.
      READ TABLE lt_classtypes TRANSPORTING NO FIELDS WITH TABLE KEY table_line = ls_class_header-classtype.
      IF sy-subrc <> 0.
        DELETE me->mt_intersected_dom_val WHERE classtype = ls_class_header-classtype.
        " Delete the corresponding entry from mt_characteristic_ref as well.
        DELETE me->mt_characteristic_ref WHERE classtype = ls_class_header-classtype.
        INSERT ls_class_header-classtype INTO TABLE lt_classtypes.
      ENDIF.
    ELSE.
      CONTINUE.
    ENDIF.
    <ls_class>-class_object->get_characteristics(
      IMPORTING
        et_characteristic          = DATA(lt_class_characteristic)
        et_characteristic_org_area = DATA(lt_class_charc_org_area)
    ).
    LOOP AT lt_class_characteristic ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).
      DATA(ls_characteristic_header) = <ls_class_characteristic>-characteristic_object->get_header( ).

      " Check if me->mt_characteristic_ref already contains this characteristic.
      ASSIGN me->mt_characteristic_ref[ classtype       = ls_class_header-classtype
                                        charcinternalid = <ls_class_characteristic>-charcinternalid ]
        TO FIELD-SYMBOL(<ls_characteristic_ref>).
      IF sy-subrc <> 0.
        APPEND VALUE #(
          classtype          = ls_class_header-classtype
          charcinternalid    = <ls_class_characteristic>-charcinternalid
          characteristic_ref = <ls_class_characteristic>-characteristic_object->get_characteristic_ref( ) )
        TO me->mt_characteristic_ref.
      ELSE.
        <ls_characteristic_ref>-characteristic_ref = <ls_class_characteristic>-characteristic_object->get_characteristic_ref( ).
      ENDIF.

      ls_collected_char_value-classinternalid = ls_class_header-classinternalid.
      ls_collected_char_value-charcinternalid = ls_characteristic_header-charcinternalid.
      ls_collected_char_value-key_date        = is_classification_key-key_date.
      ls_collected_char_value-classtype       = ls_class_header-classtype.
      READ TABLE lt_class_charc_org_area ASSIGNING FIELD-SYMBOL(<ls_class_charc_org_area>)
        WITH KEY charcinternalid = <ls_class_characteristic>-charcinternalid
                 key_date        = <ls_class_characteristic>-key_date.
      IF sy-subrc = 0.
        ls_collected_char_value-clfnorganizationalarea = <ls_class_charc_org_area>-clfnorganizationalarea.
      ENDIF.
      MOVE-CORRESPONDING ls_characteristic_header TO ls_collected_char_value-characteristic_head.
      IF ls_characteristic_header-charccheckfunctionmodule IS INITIAL AND
         ls_characteristic_header-charcchecktable IS INITIAL.
        MOVE-CORRESPONDING <ls_class_characteristic>-characteristic_object->get_domain_values( ) TO ls_collected_char_value-charc_values.
      ENDIF.
      APPEND ls_collected_char_value TO lt_collected_char_value.
    ENDLOOP.
  ENDLOOP.

  LOOP AT lt_classtypes ASSIGNING FIELD-SYMBOL(<lv_classtype>).
    CLEAR: lt_charcinternalid.
    LOOP AT lt_collected_char_value ASSIGNING FIELD-SYMBOL(<ls_collected_char_values>)
      WHERE classtype = <lv_classtype>.
      APPEND <ls_collected_char_values>-charcinternalid TO lt_charcinternalid.
    ENDLOOP.
    SORT lt_charcinternalid ASCENDING BY table_line.
    DELETE ADJACENT DUPLICATES FROM lt_charcinternalid COMPARING table_line.

    LOOP AT lt_charcinternalid ASSIGNING FIELD-SYMBOL(<lv_charcinternalid>).
      CLEAR: lt_collected_char_value_tmp, lv_charcdatatype.
      LOOP AT lt_collected_char_value ASSIGNING <ls_collected_char_values>
        WHERE classtype       = <lv_classtype>
          AND charcinternalid = <lv_charcinternalid>.
        IF lv_charcdatatype IS INITIAL.
          lv_charcdatatype = <ls_collected_char_values>-charcdatatype.
        ENDIF.
        APPEND <ls_collected_char_values> TO lt_collected_char_value_tmp.
      ENDLOOP.

      mo_util_intersect->calculate_intersection(
        EXPORTING
          iv_charcdatatype         = lv_charcdatatype
          it_collected_char_values = lt_collected_char_value_tmp
        IMPORTING
          es_collected_char_value  = ls_collected_char_value
      ).

      APPEND INITIAL LINE TO me->mt_intersected_dom_val ASSIGNING FIELD-SYMBOL(<ls_intersected_dom_val>).
      <ls_intersected_dom_val>-classtype              = <lv_classtype>.
      <ls_intersected_dom_val>-clfnorganizationalarea = ls_collected_char_value-clfnorganizationalarea.

      MOVE-CORRESPONDING ls_collected_char_value-characteristic_head TO <ls_intersected_dom_val>-characteristic_head.
      <ls_intersected_dom_val>-charcinternalid = ls_collected_char_value-charcinternalid.
      <ls_intersected_dom_val>-key_date        = is_classification_key-key_date.

      <ls_intersected_dom_val>-domain_values = ls_collected_char_value-charc_values.

      LOOP AT <ls_intersected_dom_val>-domain_values ASSIGNING FIELD-SYMBOL(<ls_charc_value>).
        MOVE-CORRESPONDING <ls_charc_value> TO ls_core_charc_value.
        mo_util_intersect->build_string(
          EXPORTING
            iv_charcinternalid = <ls_intersected_dom_val>-charcinternalid
            is_charc_head      = ls_collected_char_value-characteristic_head
            iv_simplify_value  = abap_true
         IMPORTING
           et_core_message     = DATA(lt_core_message)
          CHANGING
            cs_charc_value     = ls_core_charc_value
        ).
        MOVE-CORRESPONDING ls_core_charc_value TO <ls_charc_value>.

        CREATE DATA lr_characteristic_key.
        ASSIGN lr_characteristic_key->* TO <ls_characteristic_key>.
        <ls_characteristic_key>-classtype                  = <lv_classtype>.
        <ls_characteristic_key>-charcinternalid            = <ls_intersected_dom_val>-charcinternalid.
        <ls_characteristic_key>-overwrittencharcinternalid = <ls_intersected_dom_val>-overwrittencharcinternalid.
        <ls_characteristic_key>-key_date                   = is_classification_key-key_date.

        lo_clf_api_result->add_messages_from_core(
          is_classification_key = is_classification_key
          ir_ref_key            = lr_characteristic_key
          iv_ref_type           = 'NGCS_CLF_CHARACTERISTIC_KEY'
          it_core_message       = lt_core_message ).

      ENDLOOP.
    ENDLOOP.

    DELETE me->mt_recalc_classtype_range
      WHERE sign   = if_ngc_core_c=>gc_range_sign-include
        AND option = if_ngc_core_c=>gc_range_option-equals
        AND low    = <lv_classtype>
        AND high   = space.
  ENDLOOP.

  eo_clf_api_result = lo_clf_api_result.

ENDMETHOD.