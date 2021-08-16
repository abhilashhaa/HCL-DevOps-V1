METHOD if_ngc_core_cls_persistency~read_by_internal_key.

  DATA:
    lt_class_range_by_clint    TYPE tt_class_int_key_with_range,
    lt_class_range_by_clint_ch TYPE tt_class_int_key_with_range,
    ls_classinternalid_range   TYPE ts_classinternalid_range,
    lt_classtype_range         TYPE tt_classtype_range,
    ls_classtype_range         TYPE LINE OF tt_classtype_range,
    lt_keys                    LIKE it_keys,
    lt_keys_for_charc          LIKE it_keys,
    lt_core_class              TYPE ngct_core_class,
    ls_class                   TYPE ngcs_core_class,
    lv_charc_requested         TYPE boole_d VALUE abap_false,
    lv_lines_already_read      TYPE int4 VALUE 0,
    lt_class_range_to_be_read  TYPE tt_classinternalid_range.

  CLEAR: et_classes, et_class_characteristics, et_class_characteristic_values, et_characteristic_reference, et_message.

  " Check: modification is not supported yet. Locking should be false.
  ASSERT iv_lock = abap_false.

  " Check if keys are supplied
  CHECK it_keys IS NOT INITIAL.

  " Check input field should be filled
  LOOP AT it_keys TRANSPORTING NO FIELDS
    WHERE classinternalid IS INITIAL
       OR key_date        IS INITIAL.
    ASSERT 1 = 2.
  ENDLOOP.

  IF   et_class_characteristics       IS REQUESTED
    OR et_class_characteristic_values IS REQUESTED
    OR et_characteristic_reference    IS REQUESTED.
    lv_charc_requested = abap_true.
  ENDIF.

  " copy input keys, remove duplicates
  lt_keys = it_keys.
  SORT lt_keys ASCENDING BY key_date classinternalid.
  DELETE ADJACENT DUPLICATES FROM lt_keys COMPARING key_date classinternalid.

  LOOP AT lt_keys ASSIGNING FIELD-SYMBOL(<ls_key>).
    READ TABLE mt_buffered_data ASSIGNING FIELD-SYMBOL(<ls_buffered_data>)
      WITH KEY classinternalid = <ls_key>-classinternalid
               key_date        = <ls_key>-key_date.
    IF sy-subrc = 0.
      APPEND <ls_buffered_data>-class_data TO et_classes.
      IF lv_charc_requested = abap_true
        AND <ls_buffered_data>-characteristics_data_populated = abap_true.
        APPEND LINES OF <ls_buffered_data>-characteristics_data          TO et_class_characteristics.
        APPEND LINES OF <ls_buffered_data>-characteristic_values_data    TO et_class_characteristic_values.
        APPEND LINES OF <ls_buffered_data>-characteristic_reference_data TO et_characteristic_reference.
      ELSEIF lv_charc_requested = abap_true
        AND <ls_buffered_data>-characteristics_data_populated = abap_false.
        " class types should be queried because this characteristic is not populated
        APPEND <ls_key> TO lt_keys_for_charc.
        " We need to query the characteristics of this class, therefore we append class data to lt_core_class
        " (lt_core_class is the resulting table of the CDS view selection for class header)
        " it is needed in lt_core_class so that entry in lt_classtype_range is created
        " lt_classtype_range is needed to query characteristics
        APPEND <ls_buffered_data>-class_data TO lt_core_class.

      ELSEIF lv_charc_requested = abap_false
        AND <ls_buffered_data>-characteristics_data_populated = abap_true.
        " lt_keys_for_charc and lt_core_class is NOT populated in this case
      ELSE. " not requested and not populated
      ENDIF.
      " This class header should not be queried from CDS view
      DELETE lt_keys.
    ELSE.
      APPEND INITIAL LINE TO mt_buffered_data ASSIGNING <ls_buffered_data>.
      <ls_buffered_data>-classinternalid = <ls_key>-classinternalid.
      <ls_buffered_data>-key_date        = <ls_key>-key_date.
      IF lv_charc_requested = abap_true.
        " class types should be queried because this characteristic is not populated
        APPEND <ls_key> TO lt_keys_for_charc.
      ENDIF.
    ENDIF.
  ENDLOOP.

  " Build ranges by class internal ID to be able to select from CDS view
  " (Referencing to association with FOR ALL ENTRIES is not supported by the CDS views)
  ls_classinternalid_range-sign   = if_ngc_core_c=>gc_range_sign-include.
  ls_classinternalid_range-option = if_ngc_core_c=>gc_range_option-equals.
  LOOP AT lt_keys ASSIGNING <ls_key>.
    READ TABLE lt_class_range_by_clint ASSIGNING FIELD-SYMBOL(<ls_class_range_by_clint>)
      WITH KEY key_date = <ls_key>-key_date.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO lt_class_range_by_clint ASSIGNING <ls_class_range_by_clint>.
      <ls_class_range_by_clint>-key_date = <ls_key>-key_date.
    ENDIF.
    ls_classinternalid_range-low = <ls_key>-classinternalid.
    APPEND ls_classinternalid_range TO <ls_class_range_by_clint>-classinternalid.
  ENDLOOP.

  " Build ranges for characteristic queries
  LOOP AT lt_keys_for_charc ASSIGNING <ls_key>.
    READ TABLE lt_class_range_by_clint_ch ASSIGNING <ls_class_range_by_clint>
      WITH KEY key_date = <ls_key>-key_date.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO lt_class_range_by_clint_ch ASSIGNING <ls_class_range_by_clint>.
      <ls_class_range_by_clint>-key_date = <ls_key>-key_date.
    ENDIF.
    ls_classinternalid_range-low = <ls_key>-classinternalid.
    APPEND ls_classinternalid_range TO <ls_class_range_by_clint>-classinternalid.
  ENDLOOP.

  " Select from CDS view - put into test seam for the unit test
  LOOP AT lt_class_range_by_clint ASSIGNING <ls_class_range_by_clint>.

    " Select classes
    CLEAR: lv_lines_already_read.
    WHILE lv_lines_already_read < lines( <ls_class_range_by_clint>-classinternalid ).
      CLEAR: lt_class_range_to_be_read.
      APPEND LINES OF <ls_class_range_by_clint>-classinternalid
        FROM lv_lines_already_read + 1 TO lv_lines_already_read + if_ngc_core_c=>gc_range_entries_max
        TO lt_class_range_to_be_read.
      ADD if_ngc_core_c=>gc_range_entries_max TO lv_lines_already_read.
      TEST-SEAM sel_cds_class_int_key.
        SELECT
          class~classinternalid,
          @<ls_class_range_by_clint>-key_date AS key_date,
          class~classtype,
          class~class,
          class~classstatus,
          status~classificationisallowed,
          class~classgroup,
          class~classsearchauthgrp,
          class~classclassfctnauthgrp,
          class~classmaintauthgrp,
          class~documentinforecorddocnumber,
          class~documentinforecorddoctype,
          class~documentinforecorddocpart,
          class~documentinforecorddocversion,
          class~sameclassfctnreaction,
          class~clfnorganizationalarea,
          class~classstandardorgname,
          class~classstandardnumber,
          class~classstandardstartdate,
          class~classstandardversionstartdate,
          class~classstandardversion,
          class~classstandardcharctable,
          class~classbaseunit,
          class~classisusableinbom,
          class~classislocal,
          class~validitystartdate,
          class~validityenddate
          FROM i_clfnclassforkeydate( p_keydate = @<ls_class_range_by_clint>-key_date ) AS class
          JOIN i_clfnclassstatus AS status ON
            status~classstatus = class~classstatus AND
            status~classtype   = class~classtype
          WHERE classinternalid IN @lt_class_range_to_be_read
          APPENDING CORRESPONDING FIELDS OF TABLE @lt_core_class.
      END-TEST-SEAM.
    ENDWHILE.

  ENDLOOP.

  " return characteristics data only if it is requested
  IF lv_charc_requested = abap_true.

    ls_classtype_range-sign   = if_ngc_core_c=>gc_range_sign-include.
    ls_classtype_range-option = if_ngc_core_c=>gc_range_option-equals.
    LOOP AT lt_core_class ASSIGNING FIELD-SYMBOL(<ls_core_class>).
      READ TABLE lt_classtype_range TRANSPORTING NO FIELDS
        WITH KEY low = <ls_core_class>-classtype.
      IF sy-subrc <> 0.
        ls_classtype_range-low = <ls_core_class>-classtype .
        APPEND ls_classtype_range TO lt_classtype_range.
      ENDIF.
    ENDLOOP.

    " get corresponding organizational areas
    read_org_area( lt_classtype_range ).

    " Select characteristics
    query_charchier_class_int_key( lt_class_range_by_clint_ch ).

    get_charcs_and_vals(
      EXPORTING
        it_keys                        = lt_keys_for_charc
      IMPORTING
        et_class_characteristics       = DATA(lt_class_characteristics)
        et_class_characteristic_values = DATA(lt_class_characteristic_values)
        et_characteristic_reference    = DATA(lt_characteristic_reference)
        et_message                     = DATA(lt_message)
    ).

    APPEND LINES OF lt_message TO et_message.
    APPEND LINES OF lt_class_characteristics       TO et_class_characteristics.
    APPEND LINES OF lt_class_characteristic_values TO et_class_characteristic_values.
    APPEND LINES OF lt_characteristic_reference    TO et_characteristic_reference.

  ENDIF.

  " Return error messages if class does not exist
  LOOP AT lt_keys ASSIGNING <ls_key>.
    READ TABLE lt_core_class TRANSPORTING NO FIELDS
      WITH KEY classinternalid = <ls_key>-classinternalid
               key_date        = <ls_key>-key_date.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO et_message ASSIGNING FIELD-SYMBOL(<ls_message>).
      MESSAGE e004(ngc_core_cls) WITH <ls_key>-classinternalid <ls_key>-key_date INTO DATA(lv_msg) ##NEEDED.
      MOVE-CORRESPONDING sy TO <ls_message>.
      MOVE-CORRESPONDING <ls_key> TO <ls_message>.
      DELETE mt_buffered_data WHERE classinternalid = <ls_key>-classinternalid
                                AND key_date        = <ls_key>-key_date.
    ENDIF.
  ENDLOOP.

  " Process results of selection
  LOOP AT lt_core_class ASSIGNING <ls_core_class>.
    READ TABLE mt_buffered_data ASSIGNING <ls_buffered_data>
      WITH KEY classinternalid = <ls_core_class>-classinternalid
               key_date        = <ls_core_class>-key_date.
    ASSERT sy-subrc = 0.
    IF <ls_buffered_data>-class IS INITIAL AND <ls_buffered_data>-classtype IS INITIAL.
      <ls_buffered_data>-class     = <ls_core_class>-class.
      <ls_buffered_data>-classtype = <ls_core_class>-classtype.
    ENDIF.
    READ TABLE mt_klah_data ASSIGNING FIELD-SYMBOL(<ls_loaded_data>) WITH KEY classinternalid = <ls_core_class>-classinternalid.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO mt_klah_data ASSIGNING <ls_loaded_data>.
    ENDIF.
    MOVE-CORRESPONDING <ls_core_class> TO <ls_loaded_data>.
    <ls_loaded_data>-object_state = if_ngc_core_c=>gc_object_state-loaded.
    MOVE-CORRESPONDING <ls_core_class> TO ls_class.
    APPEND ls_class TO et_classes.
    IF <ls_buffered_data>-class_data IS INITIAL.
      <ls_buffered_data>-class_data = ls_class.
    ENDIF.
    IF <ls_buffered_data>-characteristics_data_populated = abap_false AND lv_charc_requested = abap_true.
      LOOP AT et_class_characteristics ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>)
        WHERE classinternalid = <ls_core_class>-classinternalid.
        APPEND <ls_class_characteristic> TO <ls_buffered_data>-characteristics_data.
        LOOP AT et_characteristic_reference ASSIGNING FIELD-SYMBOL(<ls_characteristic_reference>)
          WHERE charcinternalid = <ls_class_characteristic>-charcinternalid.
          APPEND <ls_characteristic_reference> TO <ls_buffered_data>-characteristic_reference_data.
        ENDLOOP.
      ENDLOOP.
      LOOP AT et_class_characteristic_values ASSIGNING FIELD-SYMBOL(<ls_class_characteristic_val>)
        WHERE classinternalid = <ls_core_class>-classinternalid.
        APPEND <ls_class_characteristic_val> TO <ls_buffered_data>-characteristic_values_data.
      ENDLOOP.
      <ls_buffered_data>-characteristics_data_populated = abap_true.
    ENDIF.
    CLEAR: ls_class.
  ENDLOOP.

ENDMETHOD.