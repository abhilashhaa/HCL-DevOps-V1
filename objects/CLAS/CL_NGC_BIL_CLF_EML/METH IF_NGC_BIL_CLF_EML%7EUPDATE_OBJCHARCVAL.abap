  METHOD if_ngc_bil_clf_eml~update_objcharcval.

    CLEAR: es_failed, es_reported.

    MODIFY ENTITY i_clfnobjectcharcvaluetp
      UPDATE FROM it_input
        FAILED   es_failed
        REPORTED es_reported.

  ENDMETHOD.