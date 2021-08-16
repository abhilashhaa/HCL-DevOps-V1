  METHOD if_ngc_core_clf_persistency~lock.

*    LOOP AT it_classification ASSIGNING FIELD-SYMBOL(<ls_classification_upd>).
**--------------------------------------------------------------------*
**   Step I.: Process class assignments - loaded, created, updated
**--------------------------------------------------------------------*
*      LOOP AT <ls_classification_upd>-classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
*        WHERE object_state = if_ngc_core_c=>gc_object_state-loaded
*           OR object_state = if_ngc_core_c=>gc_object_state-created
*           OR object_state = if_ngc_core_c=>gc_object_state-updated.
*
*        " get class data (needed: class type, class name)
*        READ TABLE it_class ASSIGNING FIELD-SYMBOL(<ls_class>) WITH KEY classinternalid = <ls_classification_data_upd>-classinternalid.
*        ASSERT sy-subrc = 0. " should not happen!
*
*        " check if this was already locked
*        READ TABLE mt_enqueue_log TRANSPORTING NO FIELDS WITH KEY enqmode = if_ngc_core_c=>gc_enqmode-exclusive
*                                                                  klart   = <ls_class>-classtype
*                                                                  class   = <ls_class>-class
*                                                                  mafid   = if_ngc_core_c=>gc_clf_object_class_indicator-object
*                                                                  objek   = <ls_classification_upd>-object_key.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*
*        " Locking
*        lock( EXPORTING iv_classtype    = <ls_class>-classtype
*                        iv_class        = <ls_class>-class
*                        iv_clfnobjectid = <ls_classification_upd>-object_key
*                        iv_write        = abap_true
*              IMPORTING es_message      = DATA(ls_lock_message) ).
*        IF ls_lock_message IS NOT INITIAL.
*          APPEND VALUE ngcs_core_classification_msg( object_key       = <ls_classification_upd>-object_key
*                                                     technical_object = <ls_classification_upd>-technical_object
*                                                     change_number    = <ls_classification_upd>-change_number
*                                                     key_date         = <ls_classification_upd>-key_date
*                                                     msgid            = ls_lock_message-msgid
*                                                     msgty            = ls_lock_message-msgty
*                                                     msgno            = ls_lock_message-msgno
*                                                     msgv1            = ls_lock_message-msgv1
*                                                     msgv2            = ls_lock_message-msgv2
*                                                     msgv3            = ls_lock_message-msgv3
*                                                     msgv4            = ls_lock_message-msgv4 ) TO et_message.
*          CONTINUE.
*        ENDIF.
*
*        " update enqueue log table
*        INSERT VALUE #( enqmode = if_ngc_core_c=>gc_enqmode-exclusive
*                        klart   = <ls_class>-classtype
*                        class   = <ls_class>-class
*                        mafid   = if_ngc_core_c=>gc_clf_object_class_indicator-object
*                        objek   = <ls_classification_upd>-object_key ) INTO TABLE mt_enqueue_log.
*      ENDLOOP.
*
**--------------------------------------------------------------------*
**   Step II.: Process class removals
**--------------------------------------------------------------------*
*      LOOP AT <ls_classification_upd>-classification_data ASSIGNING <ls_classification_data_upd>
*        WHERE object_state = if_ngc_core_c=>gc_object_state-deleted.
*
*        " get class data (needed: class type, class name)
*        READ TABLE it_class ASSIGNING <ls_class> WITH KEY classinternalid = <ls_classification_data_upd>-classinternalid.
*        ASSERT sy-subrc = 0. " should not happen!
*
*        " check if this was already locked
*        READ TABLE mt_enqueue_log TRANSPORTING NO FIELDS WITH KEY enqmode = if_ngc_core_c=>gc_enqmode-shared
*                                                                  klart   = <ls_class>-classtype
*                                                                  class   = <ls_class>-class
*                                                                  mafid   = if_ngc_core_c=>gc_clf_object_class_indicator-object
*                                                                  objek   = <ls_classification_upd>-object_key.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*
*
*        " Locking
*        lock( EXPORTING iv_classtype    = <ls_class>-classtype
*                        iv_class        = <ls_class>-class
*                        iv_clfnobjectid = <ls_classification_upd>-object_key
*                        iv_write        = abap_false " in case of delete it is shared lock
*              IMPORTING es_message      = ls_lock_message ).
*        IF ls_lock_message IS NOT INITIAL.
*          APPEND VALUE ngcs_core_classification_msg( object_key       = <ls_classification_upd>-object_key
*                                                     technical_object = <ls_classification_upd>-technical_object
*                                                     change_number    = <ls_classification_upd>-change_number
*                                                     key_date         = <ls_classification_upd>-key_date
*                                                     msgid            = ls_lock_message-msgid
*                                                     msgty            = ls_lock_message-msgty
*                                                     msgno            = ls_lock_message-msgno
*                                                     msgv1            = ls_lock_message-msgv1
*                                                     msgv2            = ls_lock_message-msgv2
*                                                     msgv3            = ls_lock_message-msgv3
*                                                     msgv4            = ls_lock_message-msgv4 ) TO et_message.
*          CONTINUE.
*        ENDIF.
*
*        " update enqueue log table
*        INSERT VALUE #( enqmode = if_ngc_core_c=>gc_enqmode-shared
*                        klart   = <ls_class>-classtype
*                        class   = <ls_class>-class
*                        mafid   = if_ngc_core_c=>gc_clf_object_class_indicator-object
*                        objek   = <ls_classification_upd>-object_key ) INTO TABLE mt_enqueue_log.
*      ENDLOOP.
*
*    ENDLOOP.

  ENDMETHOD.