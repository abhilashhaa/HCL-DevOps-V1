  METHOD if_ngc_core_chr_persistency~read_by_internal_key.

    DATA:
      lt_key                      TYPE ngct_core_charc_key,
      lt_charc_value              TYPE ngct_core_charc_value,
      lt_charc                    TYPE ngct_core_charc,
      lt_charc_ow                 TYPE ngct_core_charc,
      ls_charc                    TYPE ngcs_core_charc,
      lt_characteristic_reference TYPE ngct_core_charc_ref,
      lt_characteristic_ref_all   TYPE ngct_core_charc_ref,
      lt_key_range_orig           TYPE tt_charc_int_key_range,
      lt_key_range_overw          TYPE tt_charc_int_key_range,
      lt_key_range_mixed          TYPE tt_charc_int_key_range,
      lt_ref_charc_range          TYPE RANGE OF atinn, " range of internal id's of reference characteristics
      lv_lines_already_read       TYPE int4 VALUE 0,
      lt_char_range_to_be_read    TYPE RANGE OF atinn.

    FIELD-SYMBOLS:
      <ls_charc_value>            TYPE ngcs_core_charc_value.


    CLEAR: et_characteristic, et_characteristic_value, et_characteristic_reference, et_message.

    " copy input keys, remove duplicates
    lt_key = it_key.
    SORT lt_key ASCENDING BY key_date charcinternalid.
    DELETE ADJACENT DUPLICATES FROM lt_key COMPARING key_date charcinternalid.

    " Check: modification is not supported yet. Locking should be false.
    ASSERT iv_lock = abap_false.

    " Check if keys are supplied
    CHECK it_key IS NOT INITIAL.

    " Check input - both fields should be filled
    LOOP AT it_key TRANSPORTING NO FIELDS
      WHERE charcinternalid IS INITIAL
         OR key_date        IS INITIAL.
      ASSERT 1 = 2.
    ENDLOOP.

    " fill output for those characteristics  which were already queried earlier
    LOOP AT lt_key ASSIGNING FIELD-SYMBOL(<ls_key>).
      READ TABLE mt_buffered_data ASSIGNING FIELD-SYMBOL(<ls_buffered_data>)
        WITH KEY charcinternalid = <ls_key>-charcinternalid
                 overwrittencharcinternalid = <ls_key>-overwrittencharcinternalid
                 key_date        = <ls_key>-key_date.
      IF sy-subrc = 0.
        APPEND LINES OF <ls_buffered_data>-charc       TO et_characteristic.
        APPEND LINES OF <ls_buffered_data>-charc_value TO et_characteristic_value.
        APPEND LINES OF <ls_buffered_data>-charc_ref   TO et_characteristic_reference.
        DELETE lt_key.
      ENDIF.
    ENDLOOP.

    SORT lt_key ASCENDING BY key_date charcinternalid.

    LOOP AT lt_key ASSIGNING <ls_key>.
      IF <ls_key>-overwrittencharcinternalid IS INITIAL.
        READ TABLE lt_key_range_orig ASSIGNING FIELD-SYMBOL(<ls_key_range_orig>)
          WITH KEY key_date = <ls_key>-key_date.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO lt_key_range_orig ASSIGNING <ls_key_range_orig>.
          <ls_key_range_orig>-key_date = <ls_key>-key_date.
        ENDIF.
        APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                        option = if_ngc_core_c=>gc_range_option-equals
                        low    = <ls_key>-charcinternalid ) TO <ls_key_range_orig>-charcinternalid.
      ENDIF.

      IF <ls_key>-overwrittencharcinternalid IS NOT INITIAL.
        READ TABLE lt_key_range_overw ASSIGNING FIELD-SYMBOL(<ls_key_range_overw>)
          WITH KEY key_date = <ls_key>-key_date.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO lt_key_range_overw ASSIGNING <ls_key_range_overw>.
          <ls_key_range_overw>-key_date = <ls_key>-key_date.
        ENDIF.
        APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                        option = if_ngc_core_c=>gc_range_option-equals
                        low    = <ls_key>-overwrittencharcinternalid ) TO <ls_key_range_overw>-charcinternalid.
      ENDIF.

      " to retrieve characteristic values properly,
      " even if the header is overwritten, the values can come from original characteristic
      READ TABLE lt_key_range_mixed ASSIGNING FIELD-SYMBOL(<ls_key_range_mixed>)
        WITH KEY key_date = <ls_key>-key_date.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO lt_key_range_mixed ASSIGNING <ls_key_range_mixed>.
        <ls_key_range_mixed>-key_date = <ls_key>-key_date.
      ENDIF.
      APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                      option = if_ngc_core_c=>gc_range_option-equals
                      low    = <ls_key>-charcinternalid ) TO <ls_key_range_mixed>-charcinternalid.
      IF <ls_key>-overwrittencharcinternalid IS NOT INITIAL.
        APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                        option = if_ngc_core_c=>gc_range_option-equals
                        low    = <ls_key>-overwrittencharcinternalid ) TO <ls_key_range_mixed>-charcinternalid.
      ENDIF.
    ENDLOOP.

*--------------------------------------------------------------------*
* Retrieve header data for normal characteristics
*--------------------------------------------------------------------*

    LOOP AT lt_key_range_orig ASSIGNING <ls_key_range_orig>.
      CLEAR: lv_lines_already_read.
      WHILE lv_lines_already_read < lines( <ls_key_range_orig>-charcinternalid ).
        CLEAR: lt_char_range_to_be_read.
        APPEND LINES OF <ls_key_range_orig>-charcinternalid
          FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
          TO lt_char_range_to_be_read.
        ADD if_ngc_core_c=>gc_range_entries_max TO lv_lines_already_read.
        TEST-SEAM select_cds_clfnchar.
          SELECT
              charcinternalid,
              @<ls_key_range_orig>-key_date AS key_date,
              characteristic,
              charcstatus,
              charcdatatype,
              charclength,
              charcdecimals,
              charctemplate,
              valueiscasesensitive,
              charcconversionroutine,
              charcgroup,
              entryisrequired,
              multiplevaluesareallowed,
              charcvalueunit,
              valueintervalisallowed,
              additionalvalueisallowed,
              negativevalueisallowed,
              validitystartdate,
              validityenddate,
              changenumber,
              documentinforecorddocnumber,
              documentinforecorddoctype,
              documentinforecorddocpart,
              documentinforecorddocversion,
              charcmaintauthgrp,
              charcisreadonly,
              charcishidden,
              charcreferencetable,
              charcreferencetablefield,
              charcchecktable,
              charccheckfunctionmodule,
              charcexponentformat,
              charcexponentvalue,                             "2819111
              charctemplateisdisplayed,
              charcentryisnotformatctrld,
              charcselectedset,
              currency,
              plant,
              charccatalogtype,
              createdbyuser,
              creationdate,
              lastchangedbyuser,
              lastchangedate
*             \_characteristicdesc( p_keydate = @<ls_key>-key_date )-charcdescription      AS charcdescription,
*             \_characteristicstatustext-charcstatusname AS charcstatusname,
*              \_unitofmeasure-unitofmeasure_e            AS unitofmeasurename
*             \_characteristicgrouptext-charcgroupname   AS charcgroupname
            FROM i_clfncharacteristicforkeydate( p_keydate = @<ls_key_range_orig>-key_date )
            WHERE charcinternalid IN @lt_char_range_to_be_read
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_charc ##TOO_MANY_ITAB_FIELDS.
        END-TEST-SEAM.

      ENDWHILE.
    ENDLOOP.

    " fill output for those characteristics  which were already queried earlier
    LOOP AT lt_key ASSIGNING <ls_key>.
      READ TABLE mt_buffered_data ASSIGNING <ls_buffered_data>
        WITH KEY charcinternalid = <ls_key>-charcinternalid
                 overwrittencharcinternalid = <ls_key>-overwrittencharcinternalid
                 key_date        = <ls_key>-key_date.
      IF sy-subrc <> 0.
        DATA(ls_charc_read) = VALUE #( lt_charc[ charcinternalid = <ls_key>-charcinternalid ] OPTIONAL ).

        IF ls_charc_read IS NOT INITIAL AND
           ( ls_charc_read-charccheckfunctionmodule IS NOT INITIAL OR
             ls_charc_read-charcchecktable IS NOT INITIAL ) AND
           iv_skip_external = abap_true OR
           et_characteristic_value IS NOT REQUESTED.
          CONTINUE.
        ENDIF.

        APPEND INITIAL LINE TO mt_buffered_data ASSIGNING <ls_buffered_data>.
        <ls_buffered_data>-charcinternalid = <ls_key>-charcinternalid.
        <ls_buffered_data>-overwrittencharcinternalid = <ls_key>-overwrittencharcinternalid.
        <ls_buffered_data>-key_date        = <ls_key>-key_date.
      ENDIF.
    ENDLOOP.

*--------------------------------------------------------------------*
* Retrieve header data for overwritten characteristics
*--------------------------------------------------------------------*

    LOOP AT lt_key_range_overw ASSIGNING <ls_key_range_overw>.
      CLEAR: lv_lines_already_read.
      WHILE lv_lines_already_read < lines( <ls_key_range_overw>-charcinternalid ).
        CLEAR: lt_char_range_to_be_read.
        APPEND LINES OF <ls_key_range_overw>-charcinternalid
          FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
          TO lt_char_range_to_be_read.
        ADD if_ngc_core_c=>gc_range_entries_max TO lv_lines_already_read.
        TEST-SEAM select_cds_clfnchar_ow.
          SELECT
              charcinternalid,
              @<ls_key_range_overw>-key_date AS key_date,
              characteristic,
              charcstatus,
              charcdatatype,
              charclength,
              charcdecimals,
              charctemplate,
              valueiscasesensitive,
              charcconversionroutine,
              charcgroup,
              entryisrequired,
              multiplevaluesareallowed,
              charcvalueunit,
              valueintervalisallowed,
              additionalvalueisallowed,
              negativevalueisallowed,
              validitystartdate,
              validityenddate,
              changenumber,
              documentinforecorddocnumber,
              documentinforecorddoctype,
              documentinforecorddocpart,
              documentinforecorddocversion,
              charcmaintauthgrp,
              charcisreadonly,
              charcishidden,
              charcreferencetable,
              charcreferencetablefield,
              charcchecktable,
              charccheckfunctionmodule,
              charcexponentformat,
              charcexponentvalue,                             "2819111
              charctemplateisdisplayed,
              charcentryisnotformatctrld,
              charcselectedset,
              currency,
              plant,
              charccatalogtype,
              createdbyuser,
              creationdate,
              lastchangedbyuser,
              lastchangedate
*             \_characteristicdesc( p_keydate = @<ls_key>-key_date )-charcdescription      AS charcdescription,
*             \_characteristicstatustext-charcstatusname AS charcstatusname,
*              \_unitofmeasure-unitofmeasure_e            AS unitofmeasurename
*             \_characteristicgrouptext-charcgroupname   AS charcgroupname
            FROM p_clfncharcoverwrite
            WHERE charcinternalid IN @lt_char_range_to_be_read
              AND validitystartdate <= @<ls_key_range_overw>-key_date
              AND validityenddate   >= @<ls_key_range_overw>-key_date
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_charc_ow ##TOO_MANY_ITAB_FIELDS.

            LOOP AT lt_charc_ow ASSIGNING FIELD-SYMBOL(<ls_charc_ow>).
               READ TABLE lt_key INTO DATA(ls_key) WITH KEY key_date                   = <ls_key_range_overw>-key_date
                                                            overwrittencharcinternalid = <ls_charc_ow>-charcinternalid.
               IF sy-subrc = 0.
                 <ls_charc_ow>-overwrittencharcinternalid = <ls_charc_ow>-charcinternalid.
                 <ls_charc_ow>-charcinternalid            = ls_key-charcinternalid.
               ENDIF.

               APPEND <ls_charc_ow> TO lt_charc.
            ENDLOOP.

        END-TEST-SEAM.

      ENDWHILE.
    ENDLOOP.

*--------------------------------------------------------------------*
* Retrieve characteristic references
* Note: this part cannot be overwritten
*--------------------------------------------------------------------*

    LOOP AT lt_key_range_orig ASSIGNING <ls_key_range_orig>.
      CLEAR: lv_lines_already_read.
      WHILE lv_lines_already_read < lines( <ls_key_range_orig>-charcinternalid ).
        CLEAR: lt_char_range_to_be_read.
        APPEND LINES OF <ls_key_range_orig>-charcinternalid
          FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
          TO lt_char_range_to_be_read.
        ADD if_ngc_core_c=>gc_range_entries_max TO lv_lines_already_read.

        CLEAR: lt_characteristic_reference.
        TEST-SEAM select_cds_charc_ref.
          SELECT * FROM i_clfncharcreference
            WHERE charcinternalid IN @lt_char_range_to_be_read
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_characteristic_reference.
        END-TEST-SEAM.
        APPEND LINES OF lt_characteristic_reference TO lt_characteristic_ref_all.

        LOOP AT lt_characteristic_reference ASSIGNING FIELD-SYMBOL(<ls_characteristic_reference>).
          APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                          option = if_ngc_core_c=>gc_range_option-equals
                          low    = <ls_characteristic_reference>-charcinternalid ) TO lt_ref_charc_range.
        ENDLOOP.

      ENDWHILE.
    ENDLOOP.

*--------------------------------------------------------------------*
* Retrieve characteristic values
* Note: this part can be overwritten, but it is not a must.
* If we have no values with the overwritten characteristic, then the
* original values must be used.
*--------------------------------------------------------------------*
 " TODO: check whether we want to allow retrieval of overwritten charc values
 " with this CDS view or rather this part should be skipped in the same way
 " as we did for the header

    LOOP AT lt_key_range_mixed ASSIGNING <ls_key_range_mixed>.
      CLEAR: lv_lines_already_read.
      WHILE lv_lines_already_read < lines( <ls_key_range_mixed>-charcinternalid ).
        CLEAR: lt_char_range_to_be_read.
        APPEND LINES OF <ls_key_range_mixed>-charcinternalid
          FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
          TO lt_char_range_to_be_read.
        ADD if_ngc_core_c=>gc_range_entries_max TO lv_lines_already_read.

        IF et_characteristic_value IS REQUESTED.
          TEST-SEAM select_cds_charc_value.
          SELECT
              charcinternalid,
              @<ls_key_range_mixed>-key_date AS key_date,
              charcvaluepositionnumber,
              charcvaluedependency,
              charcvalue,
              charcfromnumericvalue,
              charctonumericvalue,
              isdefaultvalue,
              charcfromnumericvalueunit,
              charctonumericvalueunit,
              longtextid,
              changenumber,
              validitystartdate,
              validityenddate,
              documentinforecorddocnumber,
              documentinforecorddoctype,
              documentinforecorddocpart,
              documentinforecorddocversion,
              \_characteristicvaluedesc( p_keydate = @<ls_key_range_mixed>-key_date )[ language = @sy-langu ]-charcvaluedescription AS charcvaluedescription   ##ASSOC_TO_N_OK[_CHARACTERISTICVALUEDESC]
            FROM i_clfncharcvalueforkeydate( p_keydate = @<ls_key_range_mixed>-key_date )   " CAWN selection
            WHERE charcinternalid IN @lt_char_range_to_be_read
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_charc_value.
        END-TEST-SEAM.
        ENDIF.
      ENDWHILE.
    ENDLOOP.

*--------------------------------------------------------------------*


    " check for data type of characteristic
    " This logic is partially adapted from /PLMI/CL_CLF_BO_VALUE-->CONVERT_CHARACT
    LOOP AT lt_charc ASSIGNING FIELD-SYMBOL(<ls_charc>)
      WHERE charcdatatype <> if_ngc_c=>gc_charcdatatype-char
        AND charcdatatype <> if_ngc_c=>gc_charcdatatype-num
        AND charcdatatype <> if_ngc_c=>gc_charcdatatype-curr
        AND charcdatatype <> if_ngc_c=>gc_charcdatatype-date
        AND charcdatatype <> if_ngc_c=>gc_charcdatatype-time.
      APPEND INITIAL LINE TO et_message ASSIGNING FIELD-SYMBOL(<ls_message>).
      MESSAGE e020(ngc_core_chr) WITH <ls_charc>-charcinternalid INTO DATA(lv_msg) ##NEEDED.
      MOVE-CORRESPONDING sy TO <ls_message>.
      <ls_message>-charcinternalid = <ls_charc>-charcinternalid.
      <ls_message>-key_date        = <ls_charc>-key_date.
      " remove data from buffer - this characteristic does not exist
      DELETE lt_characteristic_reference WHERE charcinternalid = <ls_charc>-charcinternalid.
      DELETE lt_charc_value WHERE charcinternalid = <ls_charc>-charcinternalid
                              AND key_date        = <ls_charc>-key_date.
      DELETE mt_buffered_data WHERE charcinternalid = <ls_charc>-charcinternalid
                                AND overwrittencharcinternalid = <ls_charc>-overwrittencharcinternalid
                                AND key_date        = <ls_charc>-key_date.
      DELETE lt_charc.
    ENDLOOP.

    " Return error messages if Characteristic does not exist
    LOOP AT lt_key ASSIGNING <ls_key>.
      READ TABLE lt_charc TRANSPORTING NO FIELDS
        WITH KEY charcinternalid = <ls_key>-charcinternalid
                 key_date        = <ls_key>-key_date.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO et_message ASSIGNING <ls_message>.
        MESSAGE e000(ngc_core_chr) WITH <ls_key>-charcinternalid <ls_key>-key_date INTO lv_msg ##NEEDED.
        MOVE-CORRESPONDING sy TO <ls_message>.
        <ls_message>-charcinternalid = <ls_key>-charcinternalid.
        <ls_message>-key_date        = <ls_key>-key_date.
        " remove data from buffer - this characteristic does not exist
        DELETE lt_characteristic_ref_all WHERE charcinternalid = <ls_key>-charcinternalid.
        DELETE lt_charc_value WHERE charcinternalid = <ls_key>-charcinternalid
                                AND key_date        = <ls_key>-key_date.
        DELETE mt_buffered_data WHERE charcinternalid = <ls_key>-charcinternalid
                                  AND key_date        = <ls_key>-key_date.
      ENDIF.
    ENDLOOP.

    " move characteristic reference data to MT_BUFFERED_DATA
    IF lt_characteristic_ref_all IS NOT INITIAL.
      LOOP AT mt_buffered_data ASSIGNING <ls_buffered_data> WHERE charcinternalid IN lt_ref_charc_range.
        LOOP AT lt_characteristic_ref_all ASSIGNING <ls_characteristic_reference>
          WHERE charcinternalid = <ls_buffered_data>-charcinternalid.
          APPEND <ls_characteristic_reference> TO: <ls_buffered_data>-charc_ref, et_characteristic_reference.
        ENDLOOP.
      ENDLOOP.
    ENDIF.

    IF et_characteristic_value IS REQUESTED AND iv_skip_external = abap_false.
      " get check table characteristic values
      get_charc_values_checktable(
        EXPORTING
          it_characteristic       = lt_charc
        IMPORTING
          et_message              = DATA(lt_message)
        CHANGING
          ct_characteristic_value = lt_charc_value
      ).

      APPEND LINES OF lt_message TO et_message.

      " get function module characteristic values
      get_charc_values_fm(
        EXPORTING
          it_characteristic       = lt_charc
        IMPORTING
          et_message              = lt_message
        CHANGING
          ct_characteristic_value = lt_charc_value
      ).

      APPEND LINES OF lt_message TO et_message.
    ENDIF.

    " Process results of selection
    LOOP AT lt_charc ASSIGNING <ls_charc>.
      " append to buffer tables
      READ TABLE mt_buffered_data ASSIGNING <ls_buffered_data>
        WITH KEY charcinternalid = <ls_charc>-charcinternalid
                 overwrittencharcinternalid = <ls_charc>-overwrittencharcinternalid
                 key_date        = <ls_charc>-key_date.
      " this characteristic should be in the buffer already
      DATA(sy_subrc) = sy-subrc.

      IF sy_subrc = 0.
        " fill external id (until now we accessed MT_BUFFERED_DATA by internal id,
        " but external id is also needed to be able to access the table from READ_BY_EXTERNAL_KEY)
        IF <ls_buffered_data>-overwrittencharcinternalid IS INITIAL.
          <ls_buffered_data>-characteristic = <ls_charc>-characteristic.
        ENDIF.
      ENDIF.

      "TODO: What is MT_LOADED_DATA used for ???  key_date ???

      " buffer the data in MT_LOADED_DATA
      READ TABLE mt_loaded_data ASSIGNING FIELD-SYMBOL(<ls_loaded_data>) WITH KEY
        characteristic              = <ls_charc>-characteristic
        overwritterncharcinternalid = <ls_charc>-overwrittencharcinternalid.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO mt_loaded_data ASSIGNING <ls_loaded_data>.
      ENDIF.

      <ls_charc>-charctemplate = me->convert_separator_to_user_mask( <ls_charc>-charctemplate ).
      MOVE-CORRESPONDING <ls_charc> TO <ls_loaded_data>.
      <ls_loaded_data>-object_state = if_ngc_core_c=>gc_object_state-loaded.
      MOVE-CORRESPONDING <ls_charc> TO ls_charc.

      IF sy_subrc = 0.
        APPEND ls_charc TO: et_characteristic, <ls_buffered_data>-charc.

        " fill output table and buffer as well
        IF <ls_buffered_data>-overwrittencharcinternalid IS NOT INITIAL.
          LOOP AT lt_charc_value ASSIGNING <ls_charc_value>
            WHERE charcinternalid = <ls_charc>-overwrittencharcinternalid.

            <ls_charc_value>-charcinternalid = <ls_buffered_data>-charcinternalid.
            APPEND <ls_charc_value> TO: et_characteristic_value, <ls_buffered_data>-charc_value.
          ENDLOOP.
        ENDIF.

        IF sy-subrc <> 0 OR <ls_buffered_data>-overwrittencharcinternalid IS INITIAL.
          LOOP AT lt_charc_value ASSIGNING <ls_charc_value>
            WHERE charcinternalid = <ls_charc>-charcinternalid.
            APPEND <ls_charc_value> TO: et_characteristic_value, <ls_buffered_data>-charc_value.
          ENDLOOP.
        ENDIF.
      ELSE.
        APPEND ls_charc TO: et_characteristic.
      ENDIF.

      CLEAR: ls_charc.

    ENDLOOP.

    " sort output tables (some entries of the output tables are coming from MT_BUFFERED_DATA)
    SORT et_characteristic           ASCENDING BY charcinternalid key_date.
    SORT et_characteristic_value     ASCENDING BY charcinternalid key_date charcvaluepositionnumber.
    SORT et_characteristic_reference ASCENDING BY charcinternalid charcreferencetable charcreferencetablefield.

  ENDMETHOD.