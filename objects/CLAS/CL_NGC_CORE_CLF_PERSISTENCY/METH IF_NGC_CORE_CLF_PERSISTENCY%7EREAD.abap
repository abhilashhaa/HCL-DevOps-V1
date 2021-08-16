  METHOD if_ngc_core_clf_persistency~read.

    DATA:
      lt_keys                 LIKE it_keys,
      lt_class_keys           TYPE ngct_core_class_key,
      ls_assigned_class       TYPE ngcs_core_classification,
      ls_assigned_class_data  LIKE LINE OF ls_assigned_class-classification_data,
      ls_valuation_data       LIKE LINE OF ls_assigned_class-valuation_data,
      lt_clfnobjectclass      TYPE STANDARD TABLE OF lty_s_objectclass,
      ls_classification       LIKE LINE OF et_classification,
      lt_clfnobjectcharcvalue TYPE STANDARD TABLE OF i_clfnobjectcharcvalforkeydate,
      lv_locking_error        TYPE boole_d VALUE abap_false,
      lt_class_of_clf         TYPE lty_t_class_of_classification,
      ls_class_of_clf         TYPE lty_s_class_of_classification.

    FIELD-SYMBOLS:
      <ls_classification> LIKE LINE OF et_classification.

    CLEAR: et_classification, et_message.

    " Checks of object key and technical object
    LOOP AT it_keys TRANSPORTING NO FIELDS
      WHERE object_key       IS INITIAL
         OR technical_object IS INITIAL.
      ASSERT 1 = 2.
    ENDLOOP.

    " Check if keys are supplied
    CHECK it_keys IS NOT INITIAL.

    " Build key table which contains the change number valid from dates as well
    lt_keys = it_keys.

    " remove duplicates
    SORT lt_keys ASCENDING BY object_key technical_object change_number key_date.
    DELETE ADJACENT DUPLICATES FROM lt_keys COMPARING object_key technical_object change_number key_date.

    " Prevention from using ECN. ECN is not supported yet.
    " This check needs to be removed when ECN handling is fully implemented.
    LOOP AT lt_keys ASSIGNING FIELD-SYMBOL(<ls_key>)
      WHERE change_number IS NOT INITIAL
         OR key_date      IS INITIAL.
      APPEND INITIAL LINE TO et_message ASSIGNING FIELD-SYMBOL(<ls_message>).
      IF <ls_key>-change_number IS NOT INITIAL.
        " Change number &1 is ignored
        MESSAGE w000(ngc_core_common) WITH <ls_key>-change_number INTO DATA(lv_msg) ##NEEDED.
      ELSEIF <ls_key>-key_date IS INITIAL.
        " For object &1 (technical object &2) the key date is mandatory
        MESSAGE w001(ngc_core_common) WITH <ls_key>-object_key <ls_key>-technical_object INTO lv_msg ##NEEDED.
      ENDIF.
      MOVE-CORRESPONDING <ls_key> TO <ls_message>.
      MOVE-CORRESPONDING sy TO <ls_message>.
      DELETE lt_keys.
    ENDLOOP.

    " use buffer to return the data
    LOOP AT lt_keys ASSIGNING <ls_key>.
      READ TABLE mt_loaded_data ASSIGNING FIELD-SYMBOL(<ls_buffered_data>)
        WITH KEY object_key       = <ls_key>-object_key
                 technical_object = <ls_key>-technical_object
                 change_number    = <ls_key>-change_number
                 key_date         = <ls_key>-key_date.
      IF sy-subrc = 0.
        APPEND <ls_buffered_data> TO et_classification.
        DELETE lt_keys.
      ENDIF.
    ENDLOOP.

    " Remove entries from the buffer
    LOOP AT lt_keys ASSIGNING <ls_key>.
      DELETE mt_kssk_changes WHERE classification_key = <ls_key>.
      DELETE mt_inob_changes WHERE classification_key = <ls_key>.
      DELETE mt_ausp_changes WHERE classification_key = <ls_key>.
    ENDLOOP.

    " Selection from class assignments CDS view
    TEST-SEAM select_cds_clfnobjtectclass.
      LOOP AT lt_keys ASSIGNING <ls_key>.
        SELECT
          clfnobjectid,
          clfnobjecttable,
          classinternalid,
          classtype,
          clfnobjectinternalid,
          clfnstatus,
          classpositionnumber,
          classisstandardclass,
          bomisrecursive,
          changenumber,
          validitystartdate,
          validityenddate,
*          lastchangedatetime,
          \_class-class,
          @<ls_key>-key_date AS key_date
          FROM i_clfnobjectclassforkeydate( p_keydate = @<ls_key>-key_date )
          WHERE clfnobjectid    = @<ls_key>-object_key
            AND clfnobjecttable = @<ls_key>-technical_object
          APPENDING CORRESPONDING FIELDS OF TABLE @lt_clfnobjectclass.
      ENDLOOP.
    END-TEST-SEAM.

    SORT lt_clfnobjectclass BY clfnobjectid classtype ASCENDING. "class ASCENDING.

    " Selection from assigned characteristic values CDS view
    TEST-SEAM select_cds_charcvalue.
      LOOP AT lt_keys ASSIGNING <ls_key>.
        SELECT * FROM i_clfnobjectcharcvalforkeydate( p_keydate = @<ls_key>-key_date )
          WHERE clfnobjectid    = @<ls_key>-object_key
            AND clfnobjecttable = @<ls_key>-technical_object
            AND clfnobjecttype  = @if_ngc_core_c=>gc_clf_object_class_indicator-object
        APPENDING CORRESPONDING FIELDS OF TABLE @lt_clfnobjectcharcvalue.
      ENDLOOP.
    END-TEST-SEAM.

    " Create Classification objects
    LOOP AT lt_keys ASSIGNING <ls_key>.
      CLEAR: ls_assigned_class.

      MOVE-CORRESPONDING <ls_key> TO ls_assigned_class-key.
      LOOP AT lt_clfnobjectclass ASSIGNING FIELD-SYMBOL(<ls_clfnobjtoclass>)
        WHERE clfnobjectid    = <ls_key>-object_key
          AND clfnobjecttable = <ls_key>-technical_object
          AND key_date        = <ls_key>-key_date.

        " Locking
        IF iv_lock = abap_true.
          lock( EXPORTING iv_classtype    = <ls_clfnobjtoclass>-classtype
                          iv_class        = <ls_clfnobjtoclass>-class
                          iv_clfnobjectid = <ls_key>-object_key
                          iv_write        = abap_false
                IMPORTING es_message      = DATA(ls_lock_message) ).
          IF ls_lock_message IS NOT INITIAL.
            DATA(ls_message) = VALUE ngcs_core_classification_msg( object_key       = <ls_key>-object_key
                                                                   technical_object = <ls_key>-technical_object
                                                                   change_number    = <ls_key>-change_number
                                                                   key_date         = <ls_key>-key_date
                                                                   msgid            = ls_lock_message-msgid
                                                                   msgty            = ls_lock_message-msgty
                                                                   msgno            = ls_lock_message-msgno
                                                                   msgv1            = ls_lock_message-msgv1
                                                                   msgv2            = ls_lock_message-msgv2
                                                                   msgv3            = ls_lock_message-msgv3
                                                                   msgv4            = ls_lock_message-msgv4 ).
            APPEND ls_message TO et_message.
            lv_locking_error = abap_true.
            EXIT.
          ENDIF.
        ENDIF.

        " collect class keys for reading class data
        " first check if we already have this data
        READ TABLE mt_classes TRANSPORTING NO FIELDS
          WITH KEY key_date        = <ls_clfnobjtoclass>-key_date
                   classinternalid = <ls_clfnobjtoclass>-classinternalid
                   BINARY SEARCH.
        IF sy-subrc <> 0.
          APPEND VALUE #( key_date = <ls_clfnobjtoclass>-key_date classinternalid = <ls_clfnobjtoclass>-classinternalid ) TO lt_class_keys.
          " collect connection of class keys and classification keys so that proper error messages can be returned
          " (if a class cannot be loaded, the error message is connected to the classification it belongs to)
          " one class can belong to multiple classifications
          APPEND VALUE #(
            class_key          = VALUE #( key_date = <ls_clfnobjtoclass>-key_date classinternalid = <ls_clfnobjtoclass>-classinternalid )
            classification_key = <ls_key> )
            TO lt_class_of_clf.
        ENDIF.

        " collect assigned class data
        MOVE-CORRESPONDING <ls_clfnobjtoclass> TO ls_assigned_class_data.

        " get status description
        ls_assigned_class_data-clfnstatusdescription = mo_util->get_clf_status_description( iv_classtype  = ls_assigned_class_data-classtype
                                                                                            iv_clfnstatus = ls_assigned_class_data-clfnstatus ).
        APPEND ls_assigned_class_data TO ls_assigned_class-classification_data.
        CLEAR: ls_assigned_class_data.

        " Append to KSSK updated data with object state 'L' - loaded
        READ TABLE mt_kssk_changes WITH KEY object_key         = <ls_key>-object_key
                                            technical_object   = <ls_key>-technical_object
                                            change_number      = <ls_key>-change_number
                                            key_date           = <ls_key>-key_date
                                            classinternalid    = <ls_clfnobjtoclass>-classinternalid
                                            ASSIGNING FIELD-SYMBOL(<ls_kssk_changes>).
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO mt_kssk_changes ASSIGNING <ls_kssk_changes>.
          <ls_kssk_changes>-object_key         = <ls_key>-object_key.
          <ls_kssk_changes>-technical_object   = <ls_key>-technical_object.
          <ls_kssk_changes>-change_number      = <ls_key>-change_number.
          <ls_kssk_changes>-key_date           = <ls_key>-key_date.
          " CDS view returns in this field always the object ID.
          " But if internal object ID is filled, it should be set here, instead of the object ID.
          " (Multiple objects allowed, INOB table is used.)
          <ls_kssk_changes>-clfnobjectid       = COND #( WHEN <ls_clfnobjtoclass>-clfnobjectinternalid IS NOT INITIAL THEN <ls_clfnobjtoclass>-clfnobjectinternalid
                                                         ELSE <ls_clfnobjtoclass>-clfnobjectid ).
          <ls_kssk_changes>-classinternalid    = <ls_clfnobjtoclass>-classinternalid.
          <ls_kssk_changes>-mafid              = if_ngc_core_c=>gc_clf_object_class_indicator-object.
          <ls_kssk_changes>-classtype          = <ls_clfnobjtoclass>-classtype.
        ENDIF.

        " set those fields which are in the CDS view but not key fields
        <ls_kssk_changes>-clfnstatus           = <ls_clfnobjtoclass>-clfnstatus.
        <ls_kssk_changes>-validitystartdate    = <ls_clfnobjtoclass>-validitystartdate.
        <ls_kssk_changes>-validityenddate      = <ls_clfnobjtoclass>-validityenddate.
        <ls_kssk_changes>-classpositionnumber  = <ls_clfnobjtoclass>-classpositionnumber.
        <ls_kssk_changes>-classisstandardclass = <ls_clfnobjtoclass>-classisstandardclass.
        <ls_kssk_changes>-bomisrecursive       = <ls_clfnobjtoclass>-bomisrecursive.
        <ls_kssk_changes>-changenumber         = <ls_clfnobjtoclass>-changenumber.
        <ls_kssk_changes>-object_state         = if_ngc_core_c=>gc_object_state-loaded.

        " In this case the internal ID is not empty, which means that the INOB table also has values
        " (class type with "Multiple objects allowed" enabled).
        IF <ls_clfnobjtoclass>-clfnobjectinternalid IS NOT INITIAL.
          " Append to INOB updated data with object state 'L' - loaded
          READ TABLE mt_inob_changes WITH KEY object_key           = <ls_key>-object_key
                                              technical_object     = <ls_key>-technical_object
                                              change_number        = <ls_key>-change_number
                                              key_date             = <ls_key>-key_date
                                              clfnobjectinternalid = <ls_clfnobjtoclass>-clfnobjectinternalid
                                              ASSIGNING FIELD-SYMBOL(<ls_inob_changes>).
          IF sy-subrc <> 0.
            APPEND INITIAL LINE TO mt_inob_changes ASSIGNING <ls_inob_changes>.
            <ls_inob_changes>-object_key           = <ls_key>-object_key.
            <ls_inob_changes>-technical_object     = <ls_key>-technical_object.
            <ls_inob_changes>-change_number        = <ls_key>-change_number.
            <ls_inob_changes>-key_date             = <ls_key>-key_date.
            <ls_inob_changes>-clfnobjectinternalid = <ls_clfnobjtoclass>-clfnobjectinternalid.
            <ls_inob_changes>-classtype            = <ls_clfnobjtoclass>-classtype.
            <ls_inob_changes>-clfnobjecttable      = <ls_clfnobjtoclass>-clfnobjecttable.
            <ls_inob_changes>-clfnobjectid         = <ls_clfnobjtoclass>-clfnobjectid.
          ENDIF.
          " set those fields which are in the CDS view but not key fields - in case of inob there is no such field (yet)!
          " TODO: SHOULD BE HERE??? (I cannot read it, what should I write back ??? (for example, when another field is changed ??))
          " ASSUMPTION: INOB fields are not changed during class assignment / removal. Only new INOB entries are created
          " or old entries are removed. Therefore for the moment it is not a problem if we don't read these fields.
*          INOB-ROBTAB
*          INOB-ROBJEK
*          INOB-CLINT
*          INOB-STATU
*          INOB-CUCOZHL
*          INOB-PARENT
*          INOB-ROOT
*          INOB-EXPERTE
*          INOB-MATNR
*          INOB-DATUV
*          INOB-TECHS
          <ls_inob_changes>-object_state = if_ngc_core_c=>gc_object_state-loaded.
        ENDIF.
      ENDLOOP.

      " handling of locking error
      " prevent processing this classification further
      IF lv_locking_error = abap_true.
        DELETE lt_clfnobjectclass
          WHERE clfnobjectid      =  <ls_key>-object_key
            AND clfnobjecttable   =  <ls_key>-technical_object
            AND validitystartdate <= <ls_key>-key_date
            AND validityenddate   >= <ls_key>-key_date.
        DELETE lt_clfnobjectcharcvalue
          WHERE clfnobjectid      =  <ls_key>-object_key
            AND validitystartdate <= <ls_key>-key_date
            AND validityenddate   >= <ls_key>-key_date.
        DELETE lt_keys.
        lv_locking_error = abap_false.
        CONTINUE.
      ENDIF.

      " Process assigned values
      LOOP AT lt_clfnobjectcharcvalue ASSIGNING FIELD-SYMBOL(<ls_clfnobjectcharcvalue>)
        WHERE clfnobjectid      =  <ls_key>-object_key
          AND validitystartdate <= <ls_key>-key_date
          AND validityenddate   >= <ls_key>-key_date.

        MOVE-CORRESPONDING <ls_clfnobjectcharcvalue> TO ls_valuation_data.
        APPEND ls_valuation_data TO ls_assigned_class-valuation_data.
        CLEAR: ls_valuation_data.

        " Append to AUSP updated data with object state 'L' - loaded
        READ TABLE mt_ausp_changes WITH KEY object_key               = <ls_key>-object_key
                                            technical_object         = <ls_key>-technical_object
                                            change_number            = <ls_key>-change_number
                                            key_date                 = <ls_key>-key_date
                                            clfnobjectid             = <ls_clfnobjectcharcvalue>-clfnobjectid
                                            charcinternalid          = <ls_clfnobjectcharcvalue>-charcinternalid
                                            charcvaluepositionnumber = <ls_clfnobjectcharcvalue>-charcvaluepositionnumber
                                            clfnobjecttype           = <ls_clfnobjectcharcvalue>-clfnobjecttype
                                            classtype                = <ls_clfnobjectcharcvalue>-classtype
*                                           timeintervalnumber       = <ls_clfnobjectcharcvalue>-timeintervalnumber
                                            ASSIGNING FIELD-SYMBOL(<ls_ausp_changes>).
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO mt_ausp_changes ASSIGNING <ls_ausp_changes>.
          <ls_ausp_changes>-object_key               = <ls_key>-object_key.
          <ls_ausp_changes>-technical_object         = <ls_key>-technical_object.
          <ls_ausp_changes>-change_number            = <ls_key>-change_number.
          <ls_ausp_changes>-key_date                 = <ls_key>-key_date.
*         <ls_ausp_changes>-clfnobjectid             = <ls_clfnobjectcharcvalue>-clfnobjectinternalid.
          <ls_ausp_changes>-clfnobjectid             = COND #(
                                                         WHEN <ls_clfnobjectcharcvalue>-clfnobjectinternalid IS NOT INITIAL
                                                         THEN <ls_clfnobjectcharcvalue>-clfnobjectinternalid
                                                         ELSE <ls_clfnobjectcharcvalue>-clfnobjectid ).
          <ls_ausp_changes>-charcinternalid          = <ls_clfnobjectcharcvalue>-charcinternalid.
          <ls_ausp_changes>-charcvaluepositionnumber = <ls_clfnobjectcharcvalue>-charcvaluepositionnumber.
          <ls_ausp_changes>-clfnobjecttype           = <ls_clfnobjectcharcvalue>-clfnobjecttype.
          <ls_ausp_changes>-classtype                = <ls_clfnobjectcharcvalue>-classtype.
*         <ls_ausp_changes>-timeintervalnumber       = <ls_clfnobjectcharcvalue>-timeintervalnumber.
        ENDIF.

        " set those fields which are in the CDS view but not key fields
        <ls_ausp_changes>-charcvalue                = <ls_clfnobjectcharcvalue>-charcvalue.
        <ls_ausp_changes>-charcfromnumericvalue     = <ls_clfnobjectcharcvalue>-charcfromnumericvalue.
        <ls_ausp_changes>-charcfromnumericvalueunit = <ls_clfnobjectcharcvalue>-charcfromnumericvalueunit.
        <ls_ausp_changes>-charctonumericvalue       = <ls_clfnobjectcharcvalue>-charctonumericvalue.
        <ls_ausp_changes>-charctonumericvalueunit   = <ls_clfnobjectcharcvalue>-charctonumericvalueunit.
        <ls_ausp_changes>-charcvaluedependency      = <ls_clfnobjectcharcvalue>-charcvaluedependency.
*--------------------------------------------------------------------*
* the function of these fields is not known yet, they are not included yet in the CDS view yet
*      <ls_ausp_changes>-attlv
*      <ls_ausp_changes>-attlb
*      <ls_ausp_changes>-atprz
*      <ls_ausp_changes>-atinc
*--------------------------------------------------------------------*
        <ls_ausp_changes>-characteristicauthor      = <ls_clfnobjectcharcvalue>-characteristicauthor.
        <ls_ausp_changes>-changenumber              = <ls_clfnobjectcharcvalue>-changenumber.
        <ls_ausp_changes>-validitystartdate         = <ls_clfnobjectcharcvalue>-validitystartdate.
*--------------------------------------------------------------------*
* the function of these fields is not known yet, they are not included yet in the CDS view yet
*      <ls_ausp_changes>-atimb
*      <ls_ausp_changes>-atzis
*      <ls_ausp_changes>-atsrt
*      <ls_ausp_changes>-atvglart
*--------------------------------------------------------------------*
        <ls_ausp_changes>-validityenddate           = <ls_clfnobjectcharcvalue>-validityenddate.
        <ls_ausp_changes>-charcfromdecimalvalue     = <ls_clfnobjectcharcvalue>-charcfromdecimalvalue.
        <ls_ausp_changes>-charctodecimalvalue       = <ls_clfnobjectcharcvalue>-charcfromdecimalvalue.
        <ls_ausp_changes>-charcfromamount           = <ls_clfnobjectcharcvalue>-charcfromamount.
        <ls_ausp_changes>-charctoamount             = <ls_clfnobjectcharcvalue>-charctoamount.
        <ls_ausp_changes>-currency                  = <ls_clfnobjectcharcvalue>-currency.
        <ls_ausp_changes>-charcfromdate             = <ls_clfnobjectcharcvalue>-charcfromdate.
        <ls_ausp_changes>-charctodate               = <ls_clfnobjectcharcvalue>-charctodate.
        <ls_ausp_changes>-charcfromtime             = <ls_clfnobjectcharcvalue>-charcfromtime.
        <ls_ausp_changes>-charctotime               = <ls_clfnobjectcharcvalue>-charctotime.
        <ls_ausp_changes>-object_state              = if_ngc_core_c=>gc_object_state-loaded.
      ENDLOOP.

      " Put classification and valuation to the loaded data
      MOVE-CORRESPONDING <ls_key> TO ls_classification-key.
      ls_classification-classification_data = ls_assigned_class-classification_data.
      ls_classification-valuation_data      = ls_assigned_class-valuation_data.
      APPEND ls_classification TO mt_loaded_data.
      APPEND ls_classification TO et_classification.

    ENDLOOP.

    SORT lt_class_keys ASCENDING BY key_date classinternalid.
    DELETE ADJACENT DUPLICATES FROM lt_class_keys COMPARING key_date classinternalid.

    " Classes are queried here, they are needed when writing classification data
    mo_cls_persistency->read_by_internal_key(
      EXPORTING
        it_keys    = lt_class_keys
        iv_lock    = abap_false
      IMPORTING
        et_classes = DATA(lt_classes)
        et_message = DATA(lt_cls_message)
    ).

    LOOP AT lt_cls_message ASSIGNING FIELD-SYMBOL(<ls_cls_message>).
      " there can be multple classifications with this class
      LOOP AT lt_class_of_clf ASSIGNING FIELD-SYMBOL(<ls_class_of_clf>)
        WHERE class_key-classinternalid = <ls_cls_message>-classinternalid
          AND class_key-key_date        = <ls_cls_message>-key_date.
        ls_message = VALUE ngcs_core_classification_msg( object_key       = <ls_class_of_clf>-classification_key-object_key
                                                         technical_object = <ls_class_of_clf>-classification_key-technical_object
                                                         change_number    = <ls_class_of_clf>-classification_key-change_number
                                                         key_date         = <ls_class_of_clf>-classification_key-key_date
                                                         msgid            = <ls_cls_message>-msgid
                                                         msgty            = <ls_cls_message>-msgty
                                                         msgno            = <ls_cls_message>-msgno
                                                         msgv1            = <ls_cls_message>-msgv1
                                                         msgv2            = <ls_cls_message>-msgv2
                                                         msgv3            = <ls_cls_message>-msgv3
                                                         msgv4            = <ls_cls_message>-msgv4 ).
        APPEND ls_message TO et_message.
      ENDLOOP.
    ENDLOOP.

    " update and re-sort class data
    APPEND LINES OF lt_classes TO mt_classes.
    SORT mt_classes ASCENDING BY key_date classinternalid.

  ENDMETHOD.