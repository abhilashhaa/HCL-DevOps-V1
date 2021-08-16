  METHOD if_ngc_core_clf_persistency~read_clf_statuses.

    rt_classification_statuses = mo_util->get_clf_statuses( iv_classtype ).

  ENDMETHOD.