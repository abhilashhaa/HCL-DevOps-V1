  METHOD if_ngc_bil_clf_transactional~finalize.

    CLEAR: es_failed, es_reported.

    mo_ngc_api->if_ngc_clf_api_write~update( mt_classification ).

  ENDMETHOD.