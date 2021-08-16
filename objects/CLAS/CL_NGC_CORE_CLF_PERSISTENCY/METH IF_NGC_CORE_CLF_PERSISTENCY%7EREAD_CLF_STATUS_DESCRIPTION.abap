  METHOD if_ngc_core_clf_persistency~read_clf_status_description.

    rv_classificationstatusdescr = mo_util->get_clf_status_description( iv_classtype  = iv_classtype
                                                                        iv_clfnstatus = iv_clfnstatus ).

  ENDMETHOD.