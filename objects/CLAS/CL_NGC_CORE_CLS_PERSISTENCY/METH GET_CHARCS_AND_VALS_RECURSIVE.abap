METHOD get_charcs_and_vals_recursive.

  DATA:
    lt_collected_char_values TYPE ngct_core_class_charc_inter,
    lv_objectid              TYPE cuobn,
    lv_index                 TYPE syst_tabix VALUE 0.

  CLEAR: es_collected_char_value.

  IF is_clfnclasshiercharcforkeydat-overwrittencharcinternalid IS NOT INITIAL.
    " 1. overwritten characteristic
    " fill characteristics header data
    READ TABLE mt_characteristic_data ASSIGNING FIELD-SYMBOL(<ls_characteristics_data>)
      WITH KEY charcinternalid            = is_clfnclasshiercharcforkeydat-charcinternalid
               overwrittencharcinternalid = is_clfnclasshiercharcforkeydat-overwrittencharcinternalid.
    ASSERT sy-subrc = 0.
    MOVE-CORRESPONDING <ls_characteristics_data> TO es_collected_char_value.

*  Already handled in CDS view level
*    READ TABLE mt_characteristic_data ASSIGNING <ls_characteristics_data>
*      WITH KEY charcinternalid = is_clfnclasshiercharcforkeydat-overwrittencharcinternalid.
*    ASSERT sy-subrc = 0.
*
*    " characteristic header fields which can be overwritten
*    es_collected_char_value-valueintervalisallowed     = overwrite_field( iv_original_field    = es_collected_char_value-valueintervalisallowed
*                                                                          iv_overwritten_field = <ls_characteristics_data>-valueintervalisallowed ).
*    es_collected_char_value-entryisrequired            = overwrite_field( iv_original_field     = es_collected_char_value-entryisrequired
*                                                                          iv_overwritten_field  = <ls_characteristics_data>-entryisrequired ).
*    es_collected_char_value-additionalvalueisallowed   = overwrite_field( iv_original_field     = es_collected_char_value-additionalvalueisallowed
*                                                                          iv_overwritten_field  = <ls_characteristics_data>-additionalvalueisallowed ).
*    es_collected_char_value-charcisreadonly            = overwrite_field( iv_original_field     = es_collected_char_value-charcisreadonly
*                                                                          iv_overwritten_field  = <ls_characteristics_data>-charcisreadonly ).
*    es_collected_char_value-charcishidden              = overwrite_field( iv_original_field     = es_collected_char_value-charcishidden
*                                                                          iv_overwritten_field  = <ls_characteristics_data>-charcishidden ).
*    es_collected_char_value-charcentryisnotformatctrld = overwrite_field( iv_original_field     = es_collected_char_value-charcentryisnotformatctrld
*                                                                          iv_overwritten_field  = <ls_characteristics_data>-charcentryisnotformatctrld ).
*    es_collected_char_value-charctemplateisdisplayed   = overwrite_field( iv_original_field     = es_collected_char_value-charctemplateisdisplayed
*                                                                          iv_overwritten_field  = <ls_characteristics_data>-charctemplateisdisplayed ).

    es_collected_char_value-documentinforecorddocnumber  = <ls_characteristics_data>-documentinforecorddocnumber.
    es_collected_char_value-documentinforecorddoctype    = <ls_characteristics_data>-documentinforecorddoctype.
    es_collected_char_value-documentinforecorddocpart    = <ls_characteristics_data>-documentinforecorddocpart.
    es_collected_char_value-documentinforecorddocversion = <ls_characteristics_data>-documentinforecorddocversion.

    " fill class key and key date
    es_collected_char_value-classinternalid = is_clfnclasshiercharcforkeydat-classinternalid.
    es_collected_char_value-key_date        = is_clfnclasshiercharcforkeydat-key_date.

    " fill values
    " binary read table and then loop from that index
    " (mt_clfncharcvalueforkeydate is sorted by charcinternalid)
    READ TABLE mt_clfncharcvalueforkeydate TRANSPORTING NO FIELDS
      WITH KEY charcinternalid            = is_clfnclasshiercharcforkeydat-charcinternalid
               overwrittencharcinternalid = is_clfnclasshiercharcforkeydat-overwrittencharcinternalid
      BINARY SEARCH.
    IF sy-subrc = 0.
      lv_index = sy-tabix.
      " use the index calculated with the read before
      LOOP AT mt_clfncharcvalueforkeydate ASSIGNING FIELD-SYMBOL(<ls_clfncharcvalueforkeydate>) FROM lv_index.
        IF <ls_clfncharcvalueforkeydate>-charcinternalid <> is_clfnclasshiercharcforkeydat-charcinternalid
          OR <ls_clfncharcvalueforkeydate>-overwrittencharcinternalid <> is_clfnclasshiercharcforkeydat-overwrittencharcinternalid.
          EXIT.
        ENDIF.
        APPEND INITIAL LINE TO es_collected_char_value-charc_values ASSIGNING FIELD-SYMBOL(<ls_class_charc_value>).
        MOVE-CORRESPONDING <ls_clfncharcvalueforkeydate> TO <ls_class_charc_value>.
        mo_util_intersect->build_string(
          EXPORTING
            iv_charcinternalid = es_collected_char_value-charcinternalid
            is_charc_head      = es_collected_char_value-characteristic_head
          CHANGING
            cs_charc_value     = <ls_class_charc_value> ).
      ENDLOOP.
    ENDIF.

  ELSEIF is_clfnclasshiercharcforkeydat-charcisinherited = abap_true.
    " 2. inherited characteristic
    LOOP AT mt_parent_objectclassbasic ASSIGNING FIELD-SYMBOL(<ls_parent_objectclassbasic>)
      WHERE clfnobjectid = is_clfnclasshiercharcforkeydat-ancestorclassinternalid.
      READ TABLE mt_clfnclasshiercharcforkeydat ASSIGNING FIELD-SYMBOL(<ls_clfnclasshiercharc_parent>)
        WITH KEY classinternalid         = is_clfnclasshiercharcforkeydat-classinternalid
                 ancestorclassinternalid = <ls_parent_objectclassbasic>-classinternalid
                 charcinternalid         = is_clfnclasshiercharcforkeydat-charcinternalid
                 key_date                = is_clfnclasshiercharcforkeydat-key_date.
      " inheritance is on a different branch
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
      get_charcs_and_vals_recursive(
        EXPORTING
          is_clfnclasshiercharcforkeydat = <ls_clfnclasshiercharc_parent>
        IMPORTING
          es_collected_char_value        = DATA(ls_collect_char_value) ).
      APPEND ls_collect_char_value TO lt_collected_char_values.
    ENDLOOP.

    calculate_intersection(
      EXPORTING
        is_clfnclasshiercharcforkeydat = is_clfnclasshiercharcforkeydat
        it_collected_char_values       = lt_collected_char_values
      IMPORTING
        es_collected_char_value        = es_collected_char_value
    ).

    LOOP AT es_collected_char_value-charc_values ASSIGNING FIELD-SYMBOL(<ls_charc_value>).
      mo_util_intersect->build_string(
        EXPORTING
          iv_simplify_value  = abap_true
          iv_charcinternalid = es_collected_char_value-charcinternalid
          is_charc_head      = es_collected_char_value-characteristic_head
        CHANGING
          cs_charc_value     = <ls_charc_value> ).
    ENDLOOP.

    " take into account the restricted values
    lv_objectid = is_clfnclasshiercharcforkeydat-ancestorclassinternalid.
    READ TABLE mt_clfnobjectcharcvalue TRANSPORTING NO FIELDS
          WITH KEY clfnobjectid    = lv_objectid
                   charcinternalid = is_clfnclasshiercharcforkeydat-charcinternalid.
    IF sy-subrc = 0.
      CLEAR: es_collected_char_value-charc_values.
      LOOP AT mt_clfnobjectcharcvalue ASSIGNING FIELD-SYMBOL(<ls_clfnobjectcharcvalue>)
        WHERE clfnobjectid = is_clfnclasshiercharcforkeydat-ancestorclassinternalid
          AND charcinternalid = is_clfnclasshiercharcforkeydat-charcinternalid.
        APPEND INITIAL LINE TO es_collected_char_value-charc_values ASSIGNING <ls_charc_value>.
        <ls_charc_value>-charcvaluepositionnumber  = <ls_clfnobjectcharcvalue>-charcvaluepositionnumber.
        <ls_charc_value>-timeintervalnumber        = <ls_clfnobjectcharcvalue>-timeintervalnumber.
        <ls_charc_value>-charcvalue                = <ls_clfnobjectcharcvalue>-charcvalue.
        <ls_charc_value>-charcfromnumericvalue     = <ls_clfnobjectcharcvalue>-charcfromnumericvalue.
        <ls_charc_value>-charcfromnumericvalueunit = <ls_clfnobjectcharcvalue>-charcfromnumericvalueunit.
        <ls_charc_value>-charctonumericvalue       = <ls_clfnobjectcharcvalue>-charctonumericvalue.
        <ls_charc_value>-charctonumericvalueunit   = <ls_clfnobjectcharcvalue>-charctonumericvalueunit.
        <ls_charc_value>-charcvaluedependency      = <ls_clfnobjectcharcvalue>-charcvaluedependency.
        <ls_charc_value>-changenumber              = <ls_clfnobjectcharcvalue>-changenumber.
        <ls_charc_value>-validitystartdate         = <ls_clfnobjectcharcvalue>-validitystartdate.
        <ls_charc_value>-validityenddate           = <ls_clfnobjectcharcvalue>-validityenddate.
        <ls_charc_value>-ismarkedfordeletion       = <ls_clfnobjectcharcvalue>-isdeleted.
        mo_util_intersect->build_string(
          EXPORTING
            iv_simplify_value  = abap_true
            iv_charcinternalid = es_collected_char_value-charcinternalid
            is_charc_head      = es_collected_char_value-characteristic_head
          CHANGING
            cs_charc_value     = <ls_charc_value> ).
        " Document-related fields (DOCUMENTTYPE, DOCNUMBER, DOCUMENTPART, DOCUMENTVERSION) are not filled from AUSP
      ENDLOOP.
    ENDIF.

  ELSE.
    " 3. own values
    " fill characteristics header data
    READ TABLE mt_characteristic_data ASSIGNING <ls_characteristics_data>
      WITH KEY charcinternalid = is_clfnclasshiercharcforkeydat-charcinternalid
               overwrittencharcinternalid = '0000000000'.
    ASSERT sy-subrc = 0.
    MOVE-CORRESPONDING <ls_characteristics_data> TO es_collected_char_value.

    " fill class key and key date
    es_collected_char_value-classinternalid = is_clfnclasshiercharcforkeydat-classinternalid.
    es_collected_char_value-key_date        = is_clfnclasshiercharcforkeydat-key_date.

    " binary read table and then loop from that index
    " (mt_clfncharcvalueforkeydate is sorted by charcinternalid)
    READ TABLE mt_clfncharcvalueforkeydate TRANSPORTING NO FIELDS
      WITH KEY charcinternalid = is_clfnclasshiercharcforkeydat-charcinternalid
               overwrittencharcinternalid = is_clfnclasshiercharcforkeydat-overwrittencharcinternalid
      BINARY SEARCH.
    IF sy-subrc = 0.
      lv_index = sy-tabix.
      " use the index calculated with the read before
      LOOP AT mt_clfncharcvalueforkeydate ASSIGNING <ls_clfncharcvalueforkeydate> FROM lv_index.
        IF <ls_clfncharcvalueforkeydate>-charcinternalid <> is_clfnclasshiercharcforkeydat-charcinternalid
          OR <ls_clfncharcvalueforkeydate>-overwrittencharcinternalid <> is_clfnclasshiercharcforkeydat-overwrittencharcinternalid.
          EXIT.
        ENDIF.
        APPEND INITIAL LINE TO es_collected_char_value-charc_values ASSIGNING <ls_class_charc_value>.
        MOVE-CORRESPONDING <ls_clfncharcvalueforkeydate> TO <ls_class_charc_value>.
        mo_util_intersect->build_string(
          EXPORTING
            iv_charcinternalid = es_collected_char_value-charcinternalid
            is_charc_head      = es_collected_char_value-characteristic_head
          CHANGING
            cs_charc_value     = <ls_class_charc_value> ).
      ENDLOOP.
    ENDIF.

  ENDIF.

ENDMETHOD.