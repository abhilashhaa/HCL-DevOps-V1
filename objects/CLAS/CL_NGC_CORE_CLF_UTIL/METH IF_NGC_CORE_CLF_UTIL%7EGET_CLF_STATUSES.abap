  METHOD if_ngc_core_clf_util~get_clf_statuses.

    DATA:
      ls_classification_status TYPE tclc.


    me->load_statuses( ).

    LOOP AT gts_clf_status ASSIGNING FIELD-SYMBOL(<ls_clf_status>) WHERE klart = iv_classtype.
      MOVE-CORRESPONDING <ls_clf_status> TO ls_classification_status.
      APPEND ls_classification_status TO rt_classification_statuses.
    ENDLOOP.

  ENDMETHOD.