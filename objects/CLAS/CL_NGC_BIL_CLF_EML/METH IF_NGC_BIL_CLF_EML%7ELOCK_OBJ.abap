  METHOD if_ngc_bil_clf_eml~lock_obj.

    CLEAR: es_failed, es_reported.

    SET LOCKS ENTITY i_clfnobjecttp
      FROM it_input
        FAILED   es_failed
        REPORTED es_reported.

  ENDMETHOD.