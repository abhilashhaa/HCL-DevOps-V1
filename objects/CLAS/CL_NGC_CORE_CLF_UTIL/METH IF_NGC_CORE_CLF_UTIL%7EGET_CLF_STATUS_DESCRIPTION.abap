  METHOD if_ngc_core_clf_util~get_clf_status_description.

    me->load_statuses( ).

    READ TABLE gts_clf_status ASSIGNING FIELD-SYMBOL(<ls_clf_status>)
      WITH TABLE KEY klart = iv_classtype
                     statu = iv_clfnstatus.
    IF sy-subrc = 0.
      rv_clfnstatusdescription = <ls_clf_status>-clfnstatusdescription.
    ENDIF.

  ENDMETHOD.