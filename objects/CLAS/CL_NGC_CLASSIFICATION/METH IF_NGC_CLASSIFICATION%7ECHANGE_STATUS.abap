  METHOD if_ngc_classification~change_status.

    mo_clf_status->change_status(
      EXPORTING
        io_classification  = me
        iv_classinternalid = iv_classinternalid
        iv_status          = iv_status
      IMPORTING
        eo_clf_api_result  = eo_clf_api_result ).

    me->refresh_classtype_statuses( ).

  ENDMETHOD.