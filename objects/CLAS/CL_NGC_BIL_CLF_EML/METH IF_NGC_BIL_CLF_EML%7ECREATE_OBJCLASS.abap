  METHOD if_ngc_bil_clf_eml~create_objclass.

    CLEAR: es_mapped, es_failed, es_reported.

    MODIFY ENTITY i_clfnobjectclasstp
      CREATE FROM it_input
        MAPPED   es_mapped
        FAILED   es_failed
        REPORTED es_reported.

  ENDMETHOD.