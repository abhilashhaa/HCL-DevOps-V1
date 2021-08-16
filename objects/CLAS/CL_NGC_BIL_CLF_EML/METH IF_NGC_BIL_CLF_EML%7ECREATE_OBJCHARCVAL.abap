  METHOD if_ngc_bil_clf_eml~create_objcharcval.

    CLEAR: es_mapped, es_failed, es_reported.

    MODIFY ENTITY i_clfnobjectcharcvaluetp
      CREATE FROM it_input
        MAPPED   es_mapped
        FAILED   es_failed
        REPORTED es_reported.

  ENDMETHOD.