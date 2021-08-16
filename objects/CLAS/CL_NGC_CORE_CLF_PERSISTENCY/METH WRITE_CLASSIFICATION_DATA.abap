  METHOD write_classification_data.

*--------------------------------------------------------------------*
* This method collects the changes made to INOB and KSSK tables.
* Currently INOB entry is not updated. Only new INOB rows are created or
* already existing INOB rows are deleted.
* During changing a class assignment, fields in the corresponding INOB
* entry are not changed.
* When a new INOB row is created, the following fields are always left initial:
*   robtab
*   robjek
*   clint
*   statu
*   cucozhl
*   parent
*   root
*   experte
*   matnr
*   datuv
*   techs
* Processing steps:
*   Step I.: Process class assignments (class assignment creations)
*   Step II/1.: Process class removals (main part)
*   Step II/2.: Post-processing of class removals - remove "created-->removed" entries from KSSK buffer
*   Step II/3.: Post-processing of class removals - remove unnecessary INOB entries as well
*   Step III.: Process classification updates (changes of classification attributes)
*--------------------------------------------------------------------*

    DATA:
      lv_cuobj TYPE cuobj.

    CLEAR: et_message.

    LOOP AT it_classification ASSIGNING FIELD-SYMBOL(<ls_classification_upd>).

*--------------------------------------------------------------------*
*   Step I.: Process class assignments
*--------------------------------------------------------------------*
      LOOP AT <ls_classification_upd>-classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
        WHERE object_state = if_ngc_core_c=>gc_object_state-created.

        " get class data (needed: class type, class name)
        READ TABLE it_class ASSIGNING FIELD-SYMBOL(<ls_class>) WITH KEY classinternalid = <ls_classification_data_upd>-classinternalid.
        ASSERT sy-subrc = 0. " should not happen!

        " Locking
        lock( EXPORTING iv_classtype    = <ls_class>-classtype
                        iv_class        = <ls_class>-class
                        iv_clfnobjectid = <ls_classification_upd>-object_key
                        iv_write        = abap_true
              IMPORTING es_message      = DATA(ls_lock_message) ).
        IF ls_lock_message IS NOT INITIAL.
          APPEND VALUE ngcs_core_classification_msg( object_key       = <ls_classification_upd>-object_key
                                                     technical_object = <ls_classification_upd>-technical_object
                                                     change_number    = <ls_classification_upd>-change_number
                                                     key_date         = <ls_classification_upd>-key_date
                                                     msgid            = ls_lock_message-msgid
                                                     msgty            = ls_lock_message-msgty
                                                     msgno            = ls_lock_message-msgno
                                                     msgv1            = ls_lock_message-msgv1
                                                     msgv2            = ls_lock_message-msgv2
                                                     msgv3            = ls_lock_message-msgv3
                                                     msgv4            = ls_lock_message-msgv4 ) TO et_message.
          CONTINUE.
        ENDIF.

*     Get class type - to be able to decide if INOB entry is needed
        DATA(ls_classtype) = if_ngc_core_clf_persistency~read_classtype(
          iv_clfnobjecttable = <ls_classification_upd>-technical_object
          iv_classtype       = <ls_class>-classtype ).

        " merge changes to KSSK changes table --- here a read should be enough!
        READ TABLE mt_kssk_changes ASSIGNING FIELD-SYMBOL(<ls_kssk_changes>)
          WITH KEY object_key       = <ls_classification_upd>-object_key
                   technical_object = <ls_classification_upd>-technical_object
                   change_number    = <ls_classification_upd>-change_number
                   key_date         = <ls_classification_upd>-key_date
                   classinternalid  = <ls_classification_data_upd>-classinternalid.
        IF sy-subrc = 0.

          CASE <ls_kssk_changes>-object_state.
            WHEN if_ngc_core_c=>gc_object_state-loaded
              OR if_ngc_core_c=>gc_object_state-updated.
              " If we create a new one, it should not be loaded or already updated
              ASSERT 1 = 2.
            WHEN if_ngc_core_c=>gc_object_state-deleted
              OR if_ngc_core_c=>gc_object_state-created.
              " Update this entry and set it to updated
              <ls_kssk_changes>-classtype            = <ls_class>-classtype.
              <ls_kssk_changes>-clfnstatus           = <ls_classification_data_upd>-clfnstatus.
              <ls_kssk_changes>-classpositionnumber  = <ls_classification_data_upd>-classpositionnumber.
*           <ls_kssk_changes>-classisstandardclass = <ls_classification_data_upd>-classisstandardclass.
              IF <ls_kssk_changes>-object_state = if_ngc_core_c=>gc_object_state-deleted.
                <ls_kssk_changes>-object_state = if_ngc_core_c=>gc_object_state-updated.
              ENDIF.
*           <ls_kssk_changes>-classinternalid already contains the right value
          ENDCASE.

        ELSE.
          " There was no assignment in the buffer yet - put to the buffer.
          " This means that in INOB also does not exist any entry for this object.
          " Checking 'multiple objects allowed' and set CUOBJ accordingly
          get_cuobj(
            EXPORTING
              is_classtype          = ls_classtype
              is_classification_key = VALUE #( object_key       = <ls_classification_upd>-object_key
                                               technical_object = <ls_classification_upd>-technical_object
                                               change_number    = <ls_classification_upd>-change_number
                                               key_date         = <ls_classification_upd>-key_date )
            IMPORTING
              ev_cuobj              = lv_cuobj
              ev_cuobj_is_new       = DATA(lv_cuobj_is_new) ).

          APPEND INITIAL LINE TO mt_kssk_changes ASSIGNING <ls_kssk_changes>.
          <ls_kssk_changes>-object_key           = <ls_classification_upd>-object_key.
          <ls_kssk_changes>-technical_object     = <ls_classification_upd>-technical_object.
          <ls_kssk_changes>-change_number        = <ls_classification_upd>-change_number.
          <ls_kssk_changes>-key_date             = <ls_classification_upd>-key_date.
          <ls_kssk_changes>-clfnobjectid         = COND #( WHEN lv_cuobj IS NOT INITIAL THEN lv_cuobj ELSE <ls_classification_upd>-object_key ).
          <ls_kssk_changes>-classinternalid      = <ls_classification_data_upd>-classinternalid.
          <ls_kssk_changes>-classtype            = <ls_class>-classtype.
          <ls_kssk_changes>-clfnstatus           = <ls_classification_data_upd>-clfnstatus.
          <ls_kssk_changes>-mafid                = if_ngc_core_c=>gc_clf_object_class_indicator.
          <ls_kssk_changes>-timeintervalnumber   = 0. " no ECN - KSSK-ADZHL is left initial
          <ls_kssk_changes>-classpositionnumber  = <ls_classification_data_upd>-classpositionnumber.
*       <ls_kssk_changes>-classisstandardclass = <ls_classification_data_upd>-classisstandardclass.
          <ls_kssk_changes>-bomisrecursive       = abap_false.
          <ls_kssk_changes>-changenumber         = space. " no ECN - KSSK-AENNR is left initial
          <ls_kssk_changes>-validitystartdate    = if_ngc_core_c=>gc_date_zero. " no ECN - KSSK-DATUV is left initial.
          <ls_kssk_changes>-ismarkedfordeletion  = abap_false.
          <ls_kssk_changes>-validityenddate      = if_ngc_core_c=>gc_date_max.
          <ls_kssk_changes>-object_state         = if_ngc_core_c=>gc_object_state-created.

          " create INOB entry if needed
          IF ls_classtype-multipleobjtableclfnisallowed = abap_true.

            ASSERT lv_cuobj IS NOT INITIAL.

            " if CUOBJ is new, we create a new entry
            IF lv_cuobj_is_new = abap_true.

              " add new INOB entry
              APPEND INITIAL LINE TO mt_inob_changes ASSIGNING FIELD-SYMBOL(<ls_inob_changes>).
              <ls_inob_changes>-object_key           = <ls_classification_upd>-object_key.
              <ls_inob_changes>-technical_object     = <ls_classification_upd>-technical_object.
              <ls_inob_changes>-change_number        = <ls_classification_upd>-change_number.
              <ls_inob_changes>-key_date             = <ls_classification_upd>-key_date.
              <ls_inob_changes>-clfnobjectinternalid = lv_cuobj.
              <ls_inob_changes>-classtype            = <ls_class>-classtype.
              <ls_inob_changes>-clfnobjecttable      = <ls_classification_upd>-technical_object.
              <ls_inob_changes>-clfnobjectid         = <ls_classification_upd>-object_key.
*--------------------------------------------------------------------*
* Currently these fields are left empty.
*--------------------------------------------------------------------*
*           <ls_inob_changes>-robtab               = ''.
*           <ls_inob_changes>-robjek               = ''.
*           <ls_inob_changes>-clint                = ''.
*           <ls_inob_changes>-statu                = ''.
*           <ls_inob_changes>-cucozhl              = ''.
*           <ls_inob_changes>-parent               = ''.
*           <ls_inob_changes>-root                 = ''.
*           <ls_inob_changes>-experte              = ''.
*           <ls_inob_changes>-matnr                = ''.
*           <ls_inob_changes>-datuv                = ''.
*           <ls_inob_changes>-techs                = ''.
*--------------------------------------------------------------------*
              <ls_inob_changes>-object_state         = if_ngc_core_c=>gc_object_state-created.

            ELSE. " if cuobj is an already existing one, which was deleted, we set the object state to loaded
              READ TABLE mt_inob_changes ASSIGNING FIELD-SYMBOL(<ls_inob_change>)
                WITH KEY technical_object     = <ls_classification_upd>-technical_object
                         object_key           = <ls_classification_upd>-object_key
                         change_number        = <ls_classification_upd>-change_number
                         key_date             = <ls_classification_upd>-key_date
                         clfnobjectinternalid = lv_cuobj
                         object_state         = if_ngc_core_c=>gc_object_state-deleted.
              IF sy-subrc = 0.
                <ls_inob_change>-object_state = if_ngc_core_c=>gc_object_state-loaded.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.


*--------------------------------------------------------------------*
*   Step II/1.: Process class removals (main part)
*--------------------------------------------------------------------*
      LOOP AT <ls_classification_upd>-classification_data ASSIGNING <ls_classification_data_upd>
        WHERE object_state = if_ngc_core_c=>gc_object_state-deleted.

        " get class data (needed: class type, class name)
        READ TABLE it_class ASSIGNING <ls_class> WITH KEY classinternalid = <ls_classification_data_upd>-classinternalid.
        ASSERT sy-subrc = 0. " should not happen!

        " Locking
        lock( EXPORTING iv_classtype    = <ls_class>-classtype
                        iv_class        = <ls_class>-class
                        iv_clfnobjectid = <ls_classification_upd>-object_key
                        iv_write        = abap_false " in case of delete it is shared lock
              IMPORTING es_message      = ls_lock_message ).
        IF ls_lock_message IS NOT INITIAL.
          APPEND VALUE ngcs_core_classification_msg( object_key       = <ls_classification_upd>-object_key
                                                     technical_object = <ls_classification_upd>-technical_object
                                                     change_number    = <ls_classification_upd>-change_number
                                                     key_date         = <ls_classification_upd>-key_date
                                                     msgid            = ls_lock_message-msgid
                                                     msgty            = ls_lock_message-msgty
                                                     msgno            = ls_lock_message-msgno
                                                     msgv1            = ls_lock_message-msgv1
                                                     msgv2            = ls_lock_message-msgv2
                                                     msgv3            = ls_lock_message-msgv3
                                                     msgv4            = ls_lock_message-msgv4 ) TO et_message.
          CONTINUE.
        ENDIF.

*     Get class type - to be able to decide if INOB entry is needed
        ls_classtype = if_ngc_core_clf_persistency~read_classtype(
          iv_clfnobjecttable = <ls_classification_upd>-technical_object
          iv_classtype       = <ls_class>-classtype ).

        " merge changes to KSSK changes table
        READ TABLE mt_kssk_changes ASSIGNING <ls_kssk_changes>
          WITH KEY object_key       = <ls_classification_upd>-object_key
                   technical_object = <ls_classification_upd>-technical_object
                   change_number    = <ls_classification_upd>-change_number
                   key_date         = <ls_classification_upd>-key_date
                   classinternalid  = <ls_classification_data_upd>-classinternalid.
        IF sy-subrc = 0.
          CASE <ls_kssk_changes>-object_state.
            WHEN if_ngc_core_c=>gc_object_state-loaded
              OR if_ngc_core_c=>gc_object_state-updated.
              " Set entry to deleted
              <ls_kssk_changes>-object_state = if_ngc_core_c=>gc_object_state-deleted.
*           <ls_kssk_changes>-classinternalid already contains the right value
            WHEN if_ngc_core_c=>gc_object_state-created  " in this case IT_CLASSIFICATION will not contain the entry
              OR if_ngc_core_c=>gc_object_state-deleted. " if it has already been deleted, we do not need to do anything
              ASSERT 1 = 2.
          ENDCASE.
        ENDIF.

      ENDLOOP. " <ls_classification_upd>-classification_data ---> removals
    ENDLOOP. " it_classification

*--------------------------------------------------------------------*
*   Step II/2.: Post-processing of class removals - remove "created-->removed" entries from KSSK buffer
*--------------------------------------------------------------------*
    " those entries should also be set to deleted which are in the buffer as created,
    " but are not in the input table
    LOOP AT it_classification ASSIGNING <ls_classification_upd>.
      LOOP AT mt_kssk_changes ASSIGNING <ls_kssk_changes>
        WHERE object_state = if_ngc_core_c=>gc_object_state-created
          AND object_key       = <ls_classification_upd>-object_key
          AND technical_object = <ls_classification_upd>-technical_object"2819076
          AND change_number    = <ls_classification_upd>-change_number   "2819076
          AND key_date         = <ls_classification_upd>-key_date.       "2819076
        DATA(lv_kssk_index) = sy-tabix.
        READ TABLE <ls_classification_upd>-classification_data ASSIGNING <ls_classification_data_upd>
          WITH KEY classinternalid = <ls_kssk_changes>-classinternalid.
        IF sy-subrc <> 0. " this is not in the input, because it was created, then deleted
          " --> delete from our buffer
          DELETE mt_kssk_changes INDEX lv_kssk_index.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
*--------------------------------------------------------------------*
*   Step II/3.: Post-processing of class removals - remove unnecessary INOB entries as well
*--------------------------------------------------------------------*
    " Delete INOB entries as well, if neeeded
    LOOP AT mt_kssk_changes ASSIGNING <ls_kssk_changes>
      WHERE object_state = if_ngc_core_c=>gc_object_state-deleted.

      LOOP AT mt_kssk_changes TRANSPORTING NO FIELDS
        WHERE object_key       =  <ls_kssk_changes>-object_key
          AND technical_object =  <ls_kssk_changes>-technical_object
          AND change_number    =  <ls_kssk_changes>-change_number
          AND key_date         =  <ls_kssk_changes>-key_date
          AND classtype        =  <ls_kssk_changes>-classtype
          AND object_state     <> if_ngc_core_c=>gc_object_state-deleted.
        EXIT.
      ENDLOOP.
      IF sy-subrc <> 0.
        " Get class type - to be able to decide if INOB entry is needed
        ls_classtype = if_ngc_core_clf_persistency~read_classtype(
          iv_clfnobjecttable = <ls_kssk_changes>-technical_object
          iv_classtype       = <ls_kssk_changes>-classtype ).

        IF ls_classtype-multipleobjtableclfnisallowed = abap_true.
          READ TABLE mt_inob_changes ASSIGNING <ls_inob_changes> WITH KEY object_key       = <ls_kssk_changes>-object_key
                                                                          technical_object = <ls_kssk_changes>-technical_object
                                                                          change_number    = <ls_kssk_changes>-change_number
                                                                          key_date         = <ls_kssk_changes>-key_date
                                                                          classtype        = <ls_kssk_changes>-classtype.
          ASSERT sy-subrc = 0. " should not happen!
          DATA(lv_inob_index) = sy-tabix.
          CASE <ls_inob_changes>-object_state.
            WHEN if_ngc_core_c=>gc_object_state-loaded.
              " it was loaded - set it to deleted
              <ls_inob_changes>-object_state = if_ngc_core_c=>gc_object_state-deleted.
            WHEN if_ngc_core_c=>gc_object_state-created.
              DELETE mt_inob_changes INDEX lv_inob_index.
            WHEN if_ngc_core_c=>gc_object_state-deleted.
              " If it was deleted, we do not need to do anything.
            WHEN OTHERS.
              ASSERT 1 = 2. " should not happen!
          ENDCASE.
        ENDIF.
      ENDIF.
    ENDLOOP.


*--------------------------------------------------------------------*
* Step III.: Process classification updates (changes of classification attributes)
* (Currently only changing of classification status and position number is possible.)
*--------------------------------------------------------------------*
    LOOP AT it_classification ASSIGNING <ls_classification_upd>.
      LOOP AT <ls_classification_upd>-classification_data ASSIGNING <ls_classification_data_upd>
        WHERE object_state = if_ngc_core_c=>gc_object_state-updated.

        " get class data (needed: class type, class name)
        READ TABLE it_class ASSIGNING <ls_class> WITH KEY classinternalid = <ls_classification_data_upd>-classinternalid.
        ASSERT sy-subrc = 0. " should not happen!

        " Locking
        lock( EXPORTING iv_classtype    = <ls_class>-classtype
                        iv_class        = <ls_class>-class
                        iv_clfnobjectid = <ls_classification_upd>-object_key
                        iv_write        = abap_true
              IMPORTING es_message      = ls_lock_message ).
        IF ls_lock_message IS NOT INITIAL.
          APPEND VALUE ngcs_core_classification_msg( object_key       = <ls_classification_upd>-object_key
                                                     technical_object = <ls_classification_upd>-technical_object
                                                     change_number    = <ls_classification_upd>-change_number
                                                     key_date         = <ls_classification_upd>-key_date
                                                     msgid            = ls_lock_message-msgid
                                                     msgty            = ls_lock_message-msgty
                                                     msgno            = ls_lock_message-msgno
                                                     msgv1            = ls_lock_message-msgv1
                                                     msgv2            = ls_lock_message-msgv2
                                                     msgv3            = ls_lock_message-msgv3
                                                     msgv4            = ls_lock_message-msgv4 ) TO et_message.
          CONTINUE.
        ENDIF.

*     Get class type - to be able to decide if INOB entry is needed
        ls_classtype = if_ngc_core_clf_persistency~read_classtype(
          iv_clfnobjecttable = <ls_classification_upd>-technical_object
          iv_classtype       = <ls_class>-classtype ).

        " merge changes to KSSK changes table --- here a read should be enough!
        READ TABLE mt_kssk_changes ASSIGNING <ls_kssk_changes>
          WITH KEY object_key       = <ls_classification_upd>-object_key
                   technical_object = <ls_classification_upd>-technical_object
                   change_number    = <ls_classification_upd>-change_number
                   key_date         = <ls_classification_upd>-key_date
                   classinternalid  = <ls_classification_data_upd>-classinternalid.
        IF sy-subrc = 0.

          CASE <ls_kssk_changes>-object_state.
            WHEN if_ngc_core_c=>gc_object_state-loaded.
              " Update this entry and set it to updated
              <ls_kssk_changes>-classtype            = <ls_class>-classtype.
              <ls_kssk_changes>-clfnstatus           = <ls_classification_data_upd>-clfnstatus.
              <ls_kssk_changes>-classpositionnumber  = <ls_classification_data_upd>-classpositionnumber.
*           <ls_kssk_changes>-classisstandardclass = <ls_classification_data_upd>-classisstandardclass.
              <ls_kssk_changes>-object_state         = if_ngc_core_c=>gc_object_state-updated.
*           <ls_kssk_changes>-classinternalid already contains the right value
            WHEN if_ngc_core_c=>gc_object_state-created.
              " Update this entry
              <ls_kssk_changes>-classtype            = <ls_class>-classtype.
              <ls_kssk_changes>-clfnstatus           = <ls_classification_data_upd>-clfnstatus.
              <ls_kssk_changes>-classpositionnumber  = <ls_classification_data_upd>-classpositionnumber.
            WHEN if_ngc_core_c=>gc_object_state-deleted.
              " If it was deleted, first it should be created if we would like to update it
              ASSERT 1 = 2.
            WHEN if_ngc_core_c=>gc_object_state-updated.
              " Update this entry but leave it as updated
              <ls_kssk_changes>-classtype            = <ls_class>-classtype.
              <ls_kssk_changes>-clfnstatus           = <ls_classification_data_upd>-clfnstatus.
              <ls_kssk_changes>-classpositionnumber  = <ls_classification_data_upd>-classpositionnumber.
*           <ls_kssk_changes>-classisstandardclass = <ls_classification_data_upd>-classisstandardclass.
*           <ls_kssk_changes>-classinternalid already contains the right value
*           <ls_kssk_changes>-OBJECT_STATE - leave it as it is
          ENDCASE.

        ELSE.
          " There was no assignment in the buffer yet - it cannot be updated!
          ASSERT 1 = 2.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.