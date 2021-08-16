  METHOD if_ngc_bil_clf_eml~read_objcharc.

    CLEAR: et_result, es_failed, es_reported.

    READ ENTITY i_clfnobjectcharctp
      FROM it_input
        RESULT   et_result
        FAILED   es_failed
        REPORTED es_reported.

  ENDMETHOD.