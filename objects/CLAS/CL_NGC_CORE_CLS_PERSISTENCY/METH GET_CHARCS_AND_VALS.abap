METHOD get_charcs_and_vals.

  DATA:
    lt_charc_key              TYPE ngct_core_charc_key,
    lt_inheritance_keys       TYPE tt_inh_keys_w_key_date,
    lt_core_message           TYPE ngct_core_msg,
    lt_collected_char_values  TYPE ngct_core_class_charc_inter,
    lv_objectid               TYPE cuobn,
    lv_index                  TYPE syst_tabix VALUE 0,
    lv_lines_already_read     TYPE int4 VALUE 0,
    lt_class_range_to_be_read TYPE tt_inh_keys_range.


  CLEAR: et_characteristic_reference, et_class_characteristics, et_class_characteristic_values, et_message.

  CHECK it_keys IS NOT INITIAL.

  "TODO: handle the case when a characteristic is comes from the parent (normal or overwritten)
  "      and also added directly to the class again

  " fill buffers from CDS views
  LOOP AT it_keys ASSIGNING FIELD-SYMBOL(<ls_key>).
    LOOP AT mt_clfnclasshiercharcforkeydat ASSIGNING FIELD-SYMBOL(<ls_clfnclasshiercharcforkeyd>)
      WHERE classinternalid = <ls_key>-classinternalid
        AND key_date        = <ls_key>-key_date.
      APPEND VALUE #( charcinternalid            = <ls_clfnclasshiercharcforkeyd>-charcinternalid
                      overwrittencharcinternalid = <ls_clfnclasshiercharcforkeyd>-overwrittencharcinternalid
                      key_date                   = <ls_key>-key_date ) TO lt_charc_key.
      READ TABLE lt_inheritance_keys ASSIGNING FIELD-SYMBOL(<ls_inheritance_keys>)
        WITH KEY key_date = <ls_key>-key_date.
      IF sy-subrc = 0.
        APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                        option = if_ngc_core_c=>gc_range_option-equals
                        low    = <ls_clfnclasshiercharcforkeyd>-ancestorclassinternalid ) TO <ls_inheritance_keys>-ancestorclassinternalid.
      ELSE.
        APPEND VALUE #( key_date                = <ls_key>-key_date
                        ancestorclassinternalid = VALUE #( ( sign   = if_ngc_core_c=>gc_range_sign-include
                                                             option = if_ngc_core_c=>gc_range_option-equals
                                                             low    = <ls_clfnclasshiercharcforkeyd>-ancestorclassinternalid ) ) ) TO lt_inheritance_keys.
      ENDIF.
    ENDLOOP.
    SORT lt_charc_key ASCENDING BY charcinternalid overwrittencharcinternalid key_date.
    DELETE ADJACENT DUPLICATES FROM lt_charc_key.
  ENDLOOP.

  IF lt_charc_key IS NOT INITIAL.

    mo_chr_persistency->read_by_internal_key(
      EXPORTING
        it_key                      = lt_charc_key
        iv_skip_external            = abap_true
*       iv_lock                     = ABAP_FALSE
      IMPORTING
        et_characteristic           = DATA(lt_characteristic)
        et_characteristic_value     = DATA(lt_characteristic_value)
        et_characteristic_reference = et_characteristic_reference
        et_message                  = DATA(lt_characteristic_message) ).

    " process messages returned by CHR persistency
    LOOP AT lt_characteristic_message ASSIGNING FIELD-SYMBOL(<ls_characteristic_message>).
      LOOP AT mt_clfnclasshiercharcforkeydat ASSIGNING <ls_clfnclasshiercharcforkeyd>
        WHERE charcinternalid             = <ls_characteristic_message>-charcinternalid
           AND overwrittencharcinternalid = <ls_characteristic_message>-overwrittencharcinternalid.
        READ TABLE it_keys TRANSPORTING NO FIELDS
          WITH KEY classinternalid = <ls_clfnclasshiercharcforkeyd>-classinternalid
                   key_date        = <ls_clfnclasshiercharcforkeyd>-key_date.
        IF sy-subrc = 0.
          add_messages(
            EXPORTING
              is_core_class_key     = VALUE #( classinternalid = <ls_clfnclasshiercharcforkeyd>-classinternalid
                                               key_date        = <ls_clfnclasshiercharcforkeyd>-key_date )
              it_core_charc_message = lt_characteristic_message
            CHANGING
              ct_core_class_message = et_message ).
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
      LOOP AT mt_clfnclasshiercharcforkeydat ASSIGNING <ls_clfnclasshiercharcforkeyd>
        WHERE (  charcinternalid            = <ls_characteristic>-charcinternalid
             AND overwrittencharcinternalid = <ls_characteristic>-overwrittencharcinternalid )
          AND key_date = <ls_characteristic>-key_date.
        READ TABLE it_keys TRANSPORTING NO FIELDS
          WITH KEY classinternalid = <ls_clfnclasshiercharcforkeyd>-classinternalid
                   key_date        = <ls_clfnclasshiercharcforkeyd>-key_date.
        IF sy-subrc = 0.
          APPEND INITIAL LINE TO mt_characteristic_data ASSIGNING FIELD-SYMBOL(<ls_characteristic_data>).
          <ls_characteristic_data>-classinternalid = <ls_clfnclasshiercharcforkeyd>-classinternalid.
          MOVE-CORRESPONDING <ls_characteristic> TO <ls_characteristic_data>.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
    APPEND LINES OF lt_characteristic_value TO mt_clfncharcvalueforkeydate.
  ENDIF.

  LOOP AT lt_inheritance_keys ASSIGNING <ls_inheritance_keys>.
    CLEAR: lv_lines_already_read.
    WHILE lv_lines_already_read < lines( <ls_inheritance_keys>-ancestorclassinternalid ).
      CLEAR: lt_class_range_to_be_read.
      APPEND LINES OF <ls_inheritance_keys>-ancestorclassinternalid
        FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
        TO lt_class_range_to_be_read.
      lv_lines_already_read = lines( lt_class_range_to_be_read ) + lv_lines_already_read.
      TEST-SEAM sel_cds_clfnobjcharwithvalue.
*--------------------------------------------------------------------*
*       We need to select here from i_clfnobjectcharcvaluebasic instead of
*       i_clfnobjectcharcvalforkeydate because we need simply AUSP entries
*       (no INOB involved).
*--------------------------------------------------------------------*
        SELECT
          clfnobjectid,
*         clfnobjecttable,
          charcinternalid,
          charcvaluepositionnumber,
          clfnobjecttype,
          classtype,
*         clfnobjectinternalid,
          charcvaluedependency,
          charcvalue,
          charcfromnumericvalue,
          charcfromnumericvalueunit,
          charctonumericvalue,
          charctonumericvalueunit,
          charcfromdecimalvalue,
          charctodecimalvalue,
          charcfromamount,
          charctoamount,
          currency,
          charcfromdate,
          charctodate,
          charcfromtime,
          charctotime,
          characteristicauthor,
          changenumber,
          validitystartdate,
          validityenddate,
          @<ls_inheritance_keys>-key_date AS key_date
          FROM i_clfnobjectcharcvaluebasic
            WHERE clfnobjectid    IN @lt_class_range_to_be_read
            AND validitystartdate <= @<ls_inheritance_keys>-key_date
            AND validityenddate   >= @<ls_inheritance_keys>-key_date
            AND isdeleted         =  ''
            APPENDING CORRESPONDING FIELDS OF TABLE @mt_clfnobjectcharcvalue.
      END-TEST-SEAM.

      " collect direct parents
      TEST-SEAM sel_cds_parents_objclassbasic. " KSSK selection
        SELECT * FROM i_clfnobjectclassbasic APPENDING CORRESPONDING FIELDS OF TABLE @mt_parent_objectclassbasic
          WHERE clfnobjectid IN @lt_class_range_to_be_read
            AND validitystartdate <= @<ls_inheritance_keys>-key_date
            AND validityenddate   >= @<ls_inheritance_keys>-key_date.
      END-TEST-SEAM.
    ENDWHILE.
  ENDLOOP.

  " sort after the loop
  SORT mt_clfncharcvalueforkeydate ASCENDING BY charcinternalid overwrittencharcinternalid charcvaluepositionnumber timeintervalnumber.
  DELETE ADJACENT DUPLICATES FROM mt_clfncharcvalueforkeydate COMPARING charcinternalid overwrittencharcinternalid charcvaluepositionnumber timeintervalnumber.

  LOOP AT it_keys ASSIGNING <ls_key>.

    " Loop at buffered CDS view data and process own characteristics (class key = <ls_key> AND ancestor class key = <ls_key>).
    " In each loop <ls_clfncharcvalueforkeydate> will contain one characteristic of the selected class.
    LOOP AT mt_clfnclasshiercharcforkeydat ASSIGNING <ls_clfnclasshiercharcforkeyd>
      WHERE classinternalid         = <ls_key>-classinternalid
        AND ancestorclassinternalid = <ls_key>-classinternalid
        AND key_date                = <ls_key>-key_date.

      IF <ls_clfnclasshiercharcforkeyd>-overwrittencharcinternalid IS NOT INITIAL.
        " 1. overwritten characteristic
        READ TABLE mt_characteristic_data ASSIGNING FIELD-SYMBOL(<ls_characteristics_data>)
          WITH KEY charcinternalid            = <ls_clfnclasshiercharcforkeyd>-charcinternalid
                   overwrittencharcinternalid = <ls_clfnclasshiercharcforkeyd>-overwrittencharcinternalid.
        ASSERT sy-subrc = 0.
        APPEND INITIAL LINE TO et_class_characteristics ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).
        MOVE-CORRESPONDING <ls_characteristics_data> TO <ls_class_characteristic>.

*   Already resolved in CDS View level
*        READ TABLE mt_characteristic_data ASSIGNING <ls_characteristics_data>
*          WITH KEY charcinternalid = <ls_clfnclasshiercharcforkeyd>-overwrittencharcinternalid.
*        ASSERT sy-subrc = 0.
*
*        " characteristic header fields which can be overwritten
*        " (CTCF_EVALUATE_CHARACTERISTIC (which is called from CTMS BUILD_MERKMALE) works the same way)
*        <ls_class_characteristic>-valueintervalisallowed     = overwrite_field( iv_original_field    = <ls_class_characteristic>-valueintervalisallowed
*                                                                                iv_overwritten_field = <ls_characteristics_data>-valueintervalisallowed ).
*        <ls_class_characteristic>-entryisrequired            = overwrite_field( iv_original_field     = <ls_class_characteristic>-entryisrequired
*                                                                                iv_overwritten_field  = <ls_characteristics_data>-entryisrequired ).
*        <ls_class_characteristic>-additionalvalueisallowed   = overwrite_field( iv_original_field     = <ls_class_characteristic>-additionalvalueisallowed
*                                                                                iv_overwritten_field  = <ls_characteristics_data>-additionalvalueisallowed ).
*        <ls_class_characteristic>-charcisreadonly            = overwrite_field( iv_original_field     = <ls_class_characteristic>-charcisreadonly
*                                                                                iv_overwritten_field  = <ls_characteristics_data>-charcisreadonly ).
*        <ls_class_characteristic>-charcishidden              = overwrite_field( iv_original_field     = <ls_class_characteristic>-charcishidden
*                                                                                iv_overwritten_field  = <ls_characteristics_data>-charcishidden ).
*        <ls_class_characteristic>-charcentryisnotformatctrld = overwrite_field( iv_original_field     = <ls_class_characteristic>-charcentryisnotformatctrld
*                                                                                iv_overwritten_field  = <ls_characteristics_data>-charcentryisnotformatctrld ).
*        <ls_class_characteristic>-charctemplateisdisplayed   = overwrite_field( iv_original_field     = <ls_class_characteristic>-charctemplateisdisplayed
*                                                                                iv_overwritten_field  = <ls_characteristics_data>-charctemplateisdisplayed ).

        <ls_class_characteristic>-documentinforecorddocnumber  = <ls_characteristics_data>-documentinforecorddocnumber.
        <ls_class_characteristic>-documentinforecorddoctype    = <ls_characteristics_data>-documentinforecorddoctype.
        <ls_class_characteristic>-documentinforecorddocpart    = <ls_characteristics_data>-documentinforecorddocpart.
        <ls_class_characteristic>-documentinforecorddocversion = <ls_characteristics_data>-documentinforecorddocversion.

        " fill class key and key date
        <ls_class_characteristic>-classinternalid = <ls_key>-classinternalid.
        <ls_class_characteristic>-key_date        = <ls_key>-key_date.

        " binary read table and then loop from that index
        " (mt_clfncharcvalueforkeydate is sorted by charcinternalid)
        READ TABLE mt_clfncharcvalueforkeydate TRANSPORTING NO FIELDS WITH KEY
              charcinternalid            = <ls_clfnclasshiercharcforkeyd>-charcinternalid
              overwrittencharcinternalid = <ls_clfnclasshiercharcforkeyd>-overwrittencharcinternalid
          BINARY SEARCH.
        IF sy-subrc = 0.
          lv_index = sy-tabix.
          " use the index calculated with the read before
          LOOP AT mt_clfncharcvalueforkeydate ASSIGNING FIELD-SYMBOL(<ls_clfncharcvalueforkeydate>) FROM lv_index.
            IF <ls_clfncharcvalueforkeydate>-charcinternalid <> <ls_clfnclasshiercharcforkeyd>-charcinternalid
              OR <ls_clfncharcvalueforkeydate>-overwrittencharcinternalid <> <ls_clfnclasshiercharcforkeyd>-overwrittencharcinternalid.
              EXIT.
            ENDIF.

            APPEND INITIAL LINE TO et_class_characteristic_values ASSIGNING FIELD-SYMBOL(<ls_class_charc_value>).
            MOVE-CORRESPONDING <ls_clfncharcvalueforkeydate> TO <ls_class_charc_value>.
            <ls_class_charc_value>-classinternalid = <ls_clfnclasshiercharcforkeyd>-classinternalid.
            <ls_class_charc_value>-charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid.
            <ls_class_charc_value>-key_date        = <ls_key>-key_date.
            mo_util_intersect->build_string(
              EXPORTING
                iv_charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid
                is_charc_head      = <ls_class_characteristic>-characteristic_header
              IMPORTING
                et_core_message    = lt_core_message
              CHANGING
                cs_charc_value     = <ls_class_charc_value>-characteristic_value ).
            add_messages( EXPORTING is_core_class_key     = <ls_key>
                                    it_core_message       = lt_core_message
                          CHANGING  ct_core_class_message = et_message ).
          ENDLOOP.
        ENDIF.

      ELSEIF <ls_clfnclasshiercharcforkeyd>-charcisinherited = abap_true.
        " 2. inherited characteristic
        CLEAR: lt_collected_char_values.
        LOOP AT mt_parent_objectclassbasic ASSIGNING FIELD-SYMBOL(<ls_parent_objectclassbasic>)
          WHERE clfnobjectid = <ls_key>-classinternalid.
          READ TABLE mt_clfnclasshiercharcforkeydat ASSIGNING FIELD-SYMBOL(<ls_clfnclasshiercharc_parent>)
            WITH KEY classinternalid         = <ls_key>-classinternalid
                     ancestorclassinternalid = <ls_parent_objectclassbasic>-classinternalid
                     charcinternalid         = <ls_clfnclasshiercharcforkeyd>-charcinternalid
                     key_date                = <ls_clfnclasshiercharcforkeyd>-key_date.
          " inheritance is on a different branch
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.
          get_charcs_and_vals_recursive(
            EXPORTING
              is_clfnclasshiercharcforkeydat = <ls_clfnclasshiercharc_parent>
            IMPORTING
              es_collected_char_value        = DATA(ls_collected_char_value) ).
          APPEND ls_collected_char_value TO lt_collected_char_values.
        ENDLOOP.

        calculate_intersection(
          EXPORTING
            is_clfnclasshiercharcforkeydat = <ls_clfnclasshiercharcforkeyd>
            it_collected_char_values       = lt_collected_char_values
          IMPORTING
            es_collected_char_value        = ls_collected_char_value
        ).

        LOOP AT ls_collected_char_value-charc_values ASSIGNING FIELD-SYMBOL(<ls_charc_value>).
          mo_util_intersect->build_string(
            EXPORTING
              iv_simplify_value  = abap_true
              iv_charcinternalid = ls_collected_char_value-charcinternalid
              is_charc_head      = ls_collected_char_value-characteristic_head
            IMPORTING
              et_core_message    = lt_core_message
            CHANGING
              cs_charc_value     = <ls_charc_value> ).
          add_messages( EXPORTING is_core_class_key     = <ls_key>
                                  it_core_message       = lt_core_message
                        CHANGING  ct_core_class_message = et_message ).
        ENDLOOP.

        " take into account the restricted values
        lv_objectid = <ls_key>-classinternalid.
        READ TABLE mt_clfnobjectcharcvalue TRANSPORTING NO FIELDS
          WITH KEY clfnobjectid    = lv_objectid
                   charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid.
        IF sy-subrc = 0.
          CLEAR: ls_collected_char_value-charc_values.
          LOOP AT mt_clfnobjectcharcvalue ASSIGNING FIELD-SYMBOL(<ls_clfnobjectcharcvalue>)
            WHERE clfnobjectid = <ls_key>-classinternalid
              AND charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid.
            APPEND INITIAL LINE TO ls_collected_char_value-charc_values ASSIGNING <ls_charc_value>.
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
                iv_charcinternalid = ls_collected_char_value-charcinternalid
                is_charc_head      = ls_collected_char_value-characteristic_head
              IMPORTING
                et_core_message    = lt_core_message
              CHANGING
                cs_charc_value     = <ls_charc_value> ).
            add_messages( EXPORTING is_core_class_key     = <ls_key>
                                    it_core_message       = lt_core_message
                          CHANGING  ct_core_class_message = et_message ).
            " Document-related fields (DOCUMENTTYPE, DOCNUMBER, DOCUMENTPART, DOCUMENTVERSION) are not filled from AUSP
          ENDLOOP.
        ENDIF.

        LOOP AT ls_collected_char_value-charc_values ASSIGNING FIELD-SYMBOL(<ls_core_characteristic_value>).
          APPEND INITIAL LINE TO et_class_characteristic_values ASSIGNING FIELD-SYMBOL(<ls_class_characteristic_val>).
          MOVE-CORRESPONDING <ls_core_characteristic_value> TO <ls_class_characteristic_val>.
          <ls_class_characteristic_val>-classinternalid = <ls_key>-classinternalid.
          <ls_class_characteristic_val>-charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid.
          <ls_class_characteristic_val>-key_date        = <ls_key>-key_date.
        ENDLOOP.

        IF ls_collected_char_value IS NOT INITIAL.
          APPEND INITIAL LINE TO et_class_characteristics ASSIGNING <ls_class_characteristic>.
          MOVE-CORRESPONDING ls_collected_char_value TO <ls_class_characteristic>.
          <ls_class_characteristic>-classinternalid = <ls_key>-classinternalid.
          <ls_class_characteristic>-key_date        = <ls_key>-key_date.
        ENDIF.

      ELSE.
        " 3. own values
        READ TABLE mt_characteristic_data ASSIGNING <ls_characteristics_data>
          WITH KEY charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid
                   overwrittencharcinternalid = '0000000000'.
        ASSERT sy-subrc = 0.
        APPEND INITIAL LINE TO et_class_characteristics ASSIGNING <ls_class_characteristic>.
        MOVE-CORRESPONDING <ls_characteristics_data> TO <ls_class_characteristic>.
        <ls_class_characteristic>-classinternalid = <ls_key>-classinternalid.
        <ls_class_characteristic>-key_date        = <ls_key>-key_date.

        " binary read table and then loop from that index
        " (mt_clfncharcvalueforkeydate is sorted by charcinternalid)
        READ TABLE mt_clfncharcvalueforkeydate TRANSPORTING NO FIELDS
          WITH KEY charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid
                   overwrittencharcinternalid = '0000000000'
          BINARY SEARCH.
        IF sy-subrc = 0.
          lv_index = sy-tabix.
          " use the index calculated with the read before
          LOOP AT mt_clfncharcvalueforkeydate ASSIGNING <ls_clfncharcvalueforkeydate> FROM lv_index.
            IF <ls_clfncharcvalueforkeydate>-charcinternalid <> <ls_clfnclasshiercharcforkeyd>-charcinternalid
              OR <ls_clfncharcvalueforkeydate>-overwrittencharcinternalid <> <ls_clfnclasshiercharcforkeyd>-overwrittencharcinternalid.
              EXIT.
            ENDIF.

            APPEND INITIAL LINE TO et_class_characteristic_values ASSIGNING <ls_class_charc_value>.
            MOVE-CORRESPONDING <ls_clfncharcvalueforkeydate> TO <ls_class_charc_value>.
            <ls_class_charc_value>-classinternalid = <ls_clfnclasshiercharcforkeyd>-classinternalid.
            <ls_class_charc_value>-charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid.
            <ls_class_charc_value>-key_date        = <ls_key>-key_date.
            mo_util_intersect->build_string(
              EXPORTING
                iv_charcinternalid = <ls_clfnclasshiercharcforkeyd>-charcinternalid
                is_charc_head      = <ls_class_characteristic>-characteristic_header
              IMPORTING
                et_core_message    = lt_core_message
              CHANGING
                cs_charc_value     = <ls_class_charc_value>-characteristic_value ).
            add_messages( EXPORTING is_core_class_key     = <ls_key>
                                    it_core_message       = lt_core_message
                          CHANGING  ct_core_class_message = et_message ).
          ENDLOOP.
        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDLOOP.

  fill_org_area( CHANGING ct_class_characteristic = et_class_characteristics ).

  check_org_area( CHANGING ct_class_characteristic = et_class_characteristics ).

  " set length of characteristic based on ATFOD
  " this is adapted from /PLMI/CL_CLF_BO_VALUE => CONVERT_CHARACT
  LOOP AT et_class_characteristics ASSIGNING <ls_class_characteristic>
    WHERE charcdatatype = if_ngc_c=>gc_charcdatatype-char
       OR charcdatatype = if_ngc_c=>gc_charcdatatype-num
       OR charcdatatype = if_ngc_c=>gc_charcdatatype-curr
       OR charcdatatype = if_ngc_c=>gc_charcdatatype-date
       OR charcdatatype = if_ngc_c=>gc_charcdatatype-time.
    IF <ls_class_characteristic>-charcentryisnotformatctrld = abap_true.
*      <ls_class_characteristic>-charclength = if_ngc_c=>gc_charclength_default.
    ELSEIF <ls_class_characteristic>-charcdatatype = if_ngc_c=>gc_charcdatatype-char.
      " leave it as it is
    ELSE.
      <ls_class_characteristic>-charclength = strlen( <ls_class_characteristic>-charctemplate ).
    ENDIF.
  ENDLOOP.

ENDMETHOD.